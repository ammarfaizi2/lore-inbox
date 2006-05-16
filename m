Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWEPPFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWEPPFx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWEPPFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:05:53 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:10 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751193AbWEPPFw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:05:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 16 May 2006 15:05:38.0530 (UTC) FILETIME=[30F72C20:01C678FA]
Content-class: urn:content-classes:message
Subject: Re: Wiretapping Linux?
Date: Tue, 16 May 2006 11:05:38 -0400
Message-ID: <Pine.LNX.4.61.0605161100590.27707@chaos.analogic.com>
In-Reply-To: <4469D296.8060908@perkel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Wiretapping Linux?
Thread-Index: AcZ4+jD+HBFn0+0CSkOLCsSRCEOuGg==
References: <4469D296.8060908@perkel.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Marc Perkel" <marc@perkel.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 16 May 2006, Marc Perkel wrote:

> As most of you know the United States is tapping you telephone calls and
> tracking every call you make. The next logical step is to start tapping
> your computer implanting spyware into operating systems. Since Windows
> and OS-X are proprietary this can be done more easilly with the
> cooperation of Microsoft and Apple.
>
> So what about Linux? With thousands of people working on the Kernel if
> someone from the NSA wanted to slip a back door into the Kernel, could
> the do that? I know it's open source and it could be found if anyone
> looks but is anyone looking? Is this something that would get noticed if
> someone tried to do it? I'd like to think it would, but I'm going to ask
> anyway just to make sure.
>
> Conversely, if Microsoft or Apple cooperated with the US government
> could they implant sptware without packets or hidden files being noticed?
>
> I'm in the process of writing some articles about it and want to raise
> the issue of US government implanted spyware everywhere. I know some
> people might think this a little off topic but I'd rather be safe than
> sorry. Who better to ask this question of than those who develop the kernel?
>
> Thanks in advance.


The United States Government already implants
spy-ware into the Windows Operating System.
It's called "Magic Lantern" and it was part
of the settlement that the government made
with Microsoft when it had been charged with
restraint of trade and other federal law
violations. The settlement was made when
most persons' attention was diverted after
9/11.

Since most firewalls are open for the mail
port and the http port, rumor has it that
Microsoft networking looks at spare bits in
the header (where the ECN bits are), and
if it sees a certain combination, the packet
is not a real mail or http packet, but an
instruction for Magic Lantern. Presumably,
the OS answers any request using the same
method.

 	http://www.wired.com/0,2100,48648,00.html

Putting such a method into Linux would not
be difficult now that networking is done
as a separate issue. An evil network-code
maintainer could duplicate the protocol.
However, there are certain implementation
details that would certainly attract the
attention of other kernel developers.

The most likely scenario would be for an
application to answer queries from the
outside world and send along private
information. Any distributor could do
this, even Red Hat!

FI, do you truly __know__ what all this stuff does?

   PID TTY      STAT   TIME COMMAND
     1 ?        S      0:00 init [5]
     2 ?        SW     0:00 [migration/0]
     3 ?        SWN    0:01 [ksoftirqd/0]
     4 ?        SW<    0:02 [events/0]
[SNIPPED 85 lines...]
24006 tty1     S      0:00 /sbin/mingetty tty1
26778 ?        SW     0:00 [pdflush]
27253 tty2     S      0:00 -bash
27656 tty2     R      0:00 ps ax

That's the stuff that's running on my "typical" system.
How many Trojans are running? Maybe none, but don't
bet your job on it. Just don't ever use any computer
for anything you wouldn't want to be caught doing.
It's just that simple!

Many Windows "drivers" periodically "call home." Hewlett
Packard printer drivers report how much ink is being used,
etc. They use a something called "backweb".

 	http://www.cexx.org/dlgli.htm

Backweb is spyware, deliberately introduced into products
so that manufacturers can keep track of product usage.
They don't tell you that they are spying on you. They
just do it.

It's hard to find Windows products that don't contain
such spyware. As Linux becomes more prevalent on the
desktop, you can expect to find such spyware there
too.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.lymanschool.com
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
