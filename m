Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292852AbSCOQRv>; Fri, 15 Mar 2002 11:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292858AbSCOQRc>; Fri, 15 Mar 2002 11:17:32 -0500
Received: from ns1.advfn.com ([212.161.99.144]:53010 "EHLO mail.advfn.com")
	by vger.kernel.org with ESMTP id <S292852AbSCOQRW>;
	Fri, 15 Mar 2002 11:17:22 -0500
Message-Id: <200203151617.g2FGHKs28765@mail.advfn.com>
Content-Type: text/plain; charset=US-ASCII
From: Tim Kay <timk@advfn.com>
Reply-To: timk@advfn.com
Organization: Advfn.com
To: Matt_Domsch@Dell.com
Subject: Re: Advanced Programmable Interrupt Controller (APIC)?
Date: Fri, 15 Mar 2002 16:18:58 +0000
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <71714C04806CD51193520090272892170452B462@ausxmrr502.us.dell.com>
In-Reply-To: <71714C04806CD51193520090272892170452B462@ausxmrr502.us.dell.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt,
	I'll repeat this here too:


IO APIC - APIC_IO: Testing 8254 interrupt delivery
APIC_IO: Broken MP table detected: 8254 is not connected to IOAPIC #0 intpin 
2 
APIC_IO: routing 8254 via 8259 and IOAPIC #0 intpin 0 

The above is a diagnostic from a FreeBSD box bootup, this would seem to 
suggest that the motherboard rather than Linux is at fault....

Tim

On Friday 15 Mar 2002 16:06, Matt_Domsch@Dell.com wrote:
> > Now I've
> > also heard that DELL does not properly setup the APIC chip in
> > the bios because MS os's don't use it. Have no idea if this
> > is true or not.
>
> To the best of my knowledge, BIOS and Linux work together to set up the
> APICs properly on the PowerEdge 6400 (and all our other servers too).  If
> someone has proof that we don't, and what should be done instead, please
> let me know.
>
> Thanks,
> Matt

-- 
----------------
Tim Kay
systems administrator
Advfn.com Plc - http://www.advfn.com/
timk@advfn.com
Tel: 020 7070 0941
Fax: 020 7070 0959
