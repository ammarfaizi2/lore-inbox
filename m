Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbTK1SYV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 13:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbTK1SYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 13:24:21 -0500
Received: from pop.gmx.de ([213.165.64.20]:10414 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263370AbTK1SYT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 13:24:19 -0500
X-Authenticated: #4512188
Message-ID: <3FC792CF.2040102@gmx.de>
Date: Fri, 28 Nov 2003 19:24:15 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031116
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Julien Oster <lkml-2344@mc.frodoid.org>
CC: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       ross.alexander@uk.neceur.com, Brendan Howes <brendan@netzentry.com>,
       linux-kernel@vger.kernel.org
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
References: <OF6617181D.A93B9D63-ON80256DEC.004D7534-80256DEC.0053A823@uk.neceur.com>	<200311281646.40171.s0348365@sms.ed.ac.uk> <frodoid.frodo.87zneg8ipo.fsf@usenet.frodoid.org>
In-Reply-To: <frodoid.frodo.87zneg8ipo.fsf@usenet.frodoid.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Julien Oster wrote:
> Alistair John Strachan <s0348365@sms.ed.ac.uk> writes:
> 
> Hello Alistair,
> 
> 
>>It's evidently a configuration problem, albeit BIOS, mainboard revision,
>>memory quality, etc. because I and many others like me are able to run Linux
>>2.4/2.6 with all the options you tested and still achieve absolute stability,
>>on the nForce 2 platform.
> No, it's most evidently a mainboard problem, as everybody using an
> ASUS A7N8X (Deluxe) reported so far that the mainboard will lock up
> completely unless you turn of ACPI, APIC and local APIC. There is no
> other possibility to work this lockup madness around, as many users of
> that mainboard including me really tried *everything*.

At least since kernel 2.6-test8, I thin,k ACPI works with my Abit 
nforce2 mobo. Before it crapped out.


> Unfortunately, my onboard SATA controller is significantly slower when

> HOWEVER, I tested it several times under Windows 2000 (I installed it
> solely for this purpose, my machine used to be completely Redmond
> free), and although Windows 2000 also routes the PCI interrupts via
> APIC and ACPI, there's no such lockup occuring.


Intersting. My Windows locks up, as written in the other post, though 
this seldomly occurs. Sometimes the system runs for days (using s3 and 
s4). Then it could lock-up within minutes after boot-up.

kernel26 though locks up pretty fast when apic is enbled.

What kind of SATA Adapter hat the Asus? I have a Silicon image Si3112A. 
Maybe this is the root of all evil. ItÄs driver sucks hard, as doing a 
hdparm -d1 /dev/hde craps my drive up. (Though hdparm claims the drive 
is already running in DMA mode.)

What kind of SATA controller do the Epox users have? Or don't they have 
SATA onbaord?

I know that SiI Image produced corruption with early bioses, so maybe 
this really is the weak spot.


Prakash

