Return-Path: <linux-kernel-owner+w=401wt.eu-S932722AbXABKFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932722AbXABKFd (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 05:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932725AbXABKFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 05:05:33 -0500
Received: from mail.suse.de ([195.135.220.2]:41233 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932722AbXABKFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 05:05:32 -0500
Date: Tue, 2 Jan 2007 11:05:13 +0100
From: Stefan Seyfried <seife@suse.de>
To: Lee Garrett <lee-in-berlin@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5: grub is much slower resuming from suspend-to-disk than in 2.6.18
Message-ID: <20070102100513.GA8693@suse.de>
References: <200611121436.46436.arvidjaar@mail.ru> <45844374.60903@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45844374.60903@web.de>
X-Operating-System: openSUSE 10.2 (i586), Kernel 2.6.18.2-34-default
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2006 at 08:05:24PM +0100, Lee Garrett wrote:
> Andrey Borzenkov wrote:
> > [...]
> >This is rather funny; in 2.6.19-rc5 grub is *really* slow loading kernel when I switch on the 
> >system after suspend to disk. Actually, after kernel has been loaded, the whole resuming (up to 
> >the point I have usable desktop again) takes about three time less than the process of loading 
> >kernel + initrd. During loading disk LED is constantly lit. This almost looks like kernel leaves 
> >HDD in some strange state, although I always assumed HDD/IDE is completely reinitialized in this 
> >case.
> > [...]
> 
> I had the same problem (/boot on reiserfs, grub hanging for ages after resume
> with 2.6.19), but in 2.6.19.1 it seems fixed. Do you still have this bug,
> Andrey? I didn't find an update on this issue on LKML.

I'm pretty sure this is just a coincidence, an issue about how the kernel
image is actually layed out on your filesystem. I don't think it actually
has to do anything with the version.
-- 
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg  | "Well, surrounding them's out." 
