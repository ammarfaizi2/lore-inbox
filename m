Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310366AbSCGPoI>; Thu, 7 Mar 2002 10:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310370AbSCGPn7>; Thu, 7 Mar 2002 10:43:59 -0500
Received: from elin.scali.no ([62.70.89.10]:37899 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S310366AbSCGPns>;
	Thu, 7 Mar 2002 10:43:48 -0500
Subject: Re: a faster way to gettimeofday? rdtsc strangeness
From: Terje Eggestad <terje.eggestad@scali.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        Ben Greear <greearb@candelatech.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E16iz57-0002SW-00@the-village.bc.nu>
In-Reply-To: <E16iz57-0002SW-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 07 Mar 2002 16:43:35 +0100
Message-Id: <1015515815.4373.61.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-03-07 at 15:41, Alan Cox wrote:
> > If you have a CPU that begin throttling it usually cut the CPU clock in
> > half and the rdtsc counter count half a fast.
> 
> They normally adjust the STPCLK which is just fine. I've only seen a few
> laptops that do it other ways. More fun are people running mixed 300/450
> BP6 boards where the tsc varies by cpu

Can /proc/cpuinfo really be trusted in figuring out how long a cycle is?


-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________


