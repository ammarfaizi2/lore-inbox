Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbUK0F7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbUK0F7J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 00:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbUK0Du2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:50:28 -0500
Received: from zeus.kernel.org ([204.152.189.113]:5572 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262538AbUKZTdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:33:44 -0500
Date: Fri, 26 Nov 2004 04:42:01 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Sumit Pandya <sumit@elitecore.com>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org,
       len.brown@intel.com
Subject: Re: OOPS - APIC or othere?
Message-ID: <20041126064200.GB4912@logos.cnet>
References: <Pine.LNX.4.61.0411170941130.3941@musoma.fsmlabs.com> <HGEFKOBCHAIJDIEJLAKDAEMKCAAA.sumit@elitecore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HGEFKOBCHAIJDIEJLAKDAEMKCAAA.sumit@elitecore.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2004 at 02:23:57PM +0530, Sumit Pandya wrote:
> Marcelo,
> 	No other message except my name "Sumit" ? 

Yes, because Zwane has written the message

"Sending bug report for partially patched kernel isn't easy for us to 
debug, is there no way for you to simply try booting 2.4.27?"

And I was assuming you read that. Did you?

The bugzilla entry makes it understand that Len has fixed the 
problem in 2.4.27:

------- Additional Comment #2 From Len Brown  2004-11-04 13:32 -------

shipped in 2.4.27 - closing


> Any update in my problem
> statement?	My problem is having an embaded LinuxOS and changing kernel
> version is very critical.

Zwane's statement is valid here.

> Expecting just a quick answer from anyone. Could
> following solution patch break any other functionality if applied on the top
> of 2.4.26?
> http://bugzilla.kernel.org/show_bug.cgi?id=2834
> 	I got attachemnt from the above link and applied patch. Above patch applies
> nicely and runs without any problem. But wanted just a final confirmation
> from authers.

Seems to be doing its job then isnt it?

> Thanks for your time,
> -- Sumit
> 
> > -----Original Message-----
> > From: Marcelo Tosatti [mailto:marcelo.tosatti@cyclades.com]
> > Sent: Thursday, November 25, 2004 5:46 PM
> >
> >
> > On Wed, Nov 17, 2004 at 09:42:58AM -0700, Zwane Mwaikambo wrote:
> > > On Wed, 17 Nov 2004, Sumit Pandya wrote:
> > >
> > > > 	At one of our client I faced timer problem in kernel-2.4.26
> > and I tried to
> > > > fixed with patching "arch/i386/kernel/mpparse.c" file taken from
> > > > patch-2.4.27.
> > > > ...	...	...
> > > > Mikael Pettersson:
> > > >   o i386 and x86_64 ACPI mpparse timer bug
> > > > ...	...	...
> > > > 	After booting up the system now I get OOPS. Did I applied
> > partial patch by
> > > > taking only patch for mpparse.c from the whole buntch? Does it broken
> > > > dependency to some other functionality? I've ACPI support enabled into
> > > > kernel.
> > > > 	Does following Len's patch provide solution to my OOPS?
> > > >
> > ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.4.
> 26-rc4/200
> > > 40422153228-irq2.patch
> > >
> > > Here is output of ksymsoops.
> >
> > Sending bug reports for partially patched kernels isn't easy for us to
> > debug, is there no way for you to simply try booting 2.4.27?
> 
> Sumit?
