Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316637AbSE0OgR>; Mon, 27 May 2002 10:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316640AbSE0OgQ>; Mon, 27 May 2002 10:36:16 -0400
Received: from elin.scali.no ([62.70.89.10]:5638 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S316638AbSE0OgO>;
	Mon, 27 May 2002 10:36:14 -0400
Subject: Re: i8259 and IO-APIC
From: Terje Eggestad <terje.eggestad@scali.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Eric Lemoine <Eric.Lemoine@ens-lyon.fr>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1022509621.11811.278.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 27 May 2002 16:35:57 +0200
Message-Id: <1022510160.12202.113.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-05-27 at 16:27, Alan Cox wrote:
> On Mon, 2002-05-27 at 13:35, Terje Eggestad wrote:
> > I'm a bit curious my self, in theory the IO_APIC should drastically
> > reduce interrupt latency. An x86 has two interrupt pins, IRQ and NMI.
> 
> The APIC reduces processing overhead. The APIC bus on the pentium III is
> pretty slow (I believe its a serial 4 wire bus or similar). On the
> Athlon and Pentium IV it seems to be a lot faster.
> 
> In the case of a livelock the problem is probably the cost of handling
> the IRQ and poking slowly at the chip. Latency is pretty immaterial here
> compared with irq servicing overheads.

Do you got any numbers that state that it's processing overhead, and not
HW latency that is the bulk of interrupt service time? Just curious,
I've been looking and can't find this "perceived fact" backed up by
facts anywhere. 

BTW: according to "IA-32 Intel Arch. Software Developer's Man Vol 3"
both P3 and P4 the APIC bus is three wire, two data and one clock. 

> 
> Alan


TJ

-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

