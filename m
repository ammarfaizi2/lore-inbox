Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUHJLmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUHJLmF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 07:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbUHJLmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 07:42:05 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48844 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264377AbUHJLmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 07:42:01 -0400
Date: Mon, 9 Aug 2004 21:44:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Karol Kozimor <kkozimor@aurox.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -mm swsusp: do not default to platform/firmware
Message-ID: <20040809194418.GA1862@openzaurus.ucw.cz>
References: <20040728222445.GA18210@elf.ucw.cz> <Pine.LNX.4.50.0408012313350.4359-100000@monsoon.he.net> <20040802153021.354C9AF200@voldemort.scrye.com> <200408031328.14595.kkozimor@aurox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408031328.14595.kkozimor@aurox.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Patrick> I'd rather leave it, and put pressure on the platform
> > Patrick> implementations to be made to work. If you want to shutdown,
> > Patrick> then specify it on the command line before you suspend (or
> > Patrick> add it to the suspend script).
> >
> > Does _anyone_ have a machine where platform works?
> >
> > I can't recally anyone posted on the acpi/swsusp2/kernel lists that
> > they had a platform implementation that worked.
> >
> > Perhaps they had no reason to post? Anyone out there with a laptop
> > with a suspend to disk in formware/platform using ACPI that works?
> > I'd love to be proven wrong...
> 
> I guess you mean most users of the original pmdisk code, as it originally 
> defaulted to platform (which in most cases should be ACPI S4). I mean, S4 
> is not even remotely as obscure as S3. Then again, S4BIOS or other 
> firmware methods are different beasts.
> 
> For the reference, original pmdisk code worked fine with platform on my 
> laptop the last time I checked (several months ago).
> 

Could you try again with latest -mm kernel?

It is possible that it simply got broken while it had very
small number of users.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

