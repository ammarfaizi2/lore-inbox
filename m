Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261860AbTCGXQ4>; Fri, 7 Mar 2003 18:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261867AbTCGXQ4>; Fri, 7 Mar 2003 18:16:56 -0500
Received: from wildg.gotadsl.co.uk ([81.6.236.5]:17080 "EHLO
	xunil.mail.wildgooses.com") by vger.kernel.org with ESMTP
	id <S261860AbTCGXQz>; Fri, 7 Mar 2003 18:16:55 -0500
Message-ID: <052f01c2e501$1c0c4790$0369a8c0@BigMotha>
From: "Edward Wildgoose" <ed@wildgooses.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Greg KH" <greg@kroah.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <3E68F616.3090602@Wildgooses.com> <20030307221343.GC21315@kroah.com> <1047080149.23803.25.camel@irongate.swansea.linux.org.uk>
Subject: Re: Interrupt problem, no USB on SMP machine with 2.4.19/20/21
Date: Fri, 7 Mar 2003 23:27:23 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 2003-03-07 at 22:13, Greg KH wrote:
> > Have you booted with "noapic" on the command line?  That's the only way
> > a lot of VIA motherboards will get their onboard USB controller to work
> > properly.
>
> VIA onboard devices require the interrupt line and pin are both written in
> APIC mode. Linux for reasons I still don't understand does not do that by
> default. The current -ac tree has a quirk for this although it doesnt seem
> to be working for all cases and needs a victim to review it more carefully

booting my -ac kernel with noapic gets the USB working (hooray and thanks).
I am just recompiling my gentoo-sources kernel to see if I can make that
work (it certainly doesn't without ACPI enabled).

I will play with config files and kernel sources and see if I can determine
whether anything *other* than the -ac branch will work correctly.  Is there
any way that I can usefully help feed that info back to the developers?  Are
there any tests that I can try?

Thanks for your help all

