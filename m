Return-Path: <linux-kernel-owner+w=401wt.eu-S964786AbXABMOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbXABMOr (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 07:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbXABMOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 07:14:47 -0500
Received: from ns2.suse.de ([195.135.220.15]:48223 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964786AbXABMOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 07:14:46 -0500
Date: Tue, 2 Jan 2007 13:14:36 +0100
From: Stefan Seyfried <seife@suse.de>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Lee Garrett <lee-in-berlin@web.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5: grub is much slower resuming from suspend-to-disk than in 2.6.18
Message-ID: <20070102121436.GA26069@suse.de>
References: <200611121436.46436.arvidjaar@mail.ru> <45844374.60903@web.de> <20070102100513.GA8693@suse.de> <1167735483.19781.90.camel@frg-rhel40-em64t-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1167735483.19781.90.camel@frg-rhel40-em64t-03>
X-Operating-System: openSUSE 10.2 (i586), Kernel 2.6.18.2-34-default
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2007 at 11:58:03AM +0100, Xavier Bestel wrote:
> On Tue, 2007-01-02 at 11:05 +0100, Stefan Seyfried wrote:
> > On Sat, Dec 16, 2006 at 08:05:24PM +0100, Lee Garrett wrote:
> > > I had the same problem (/boot on reiserfs, grub hanging for ages after resume
> > > with 2.6.19), but in 2.6.19.1 it seems fixed. Do you still have this bug,
> > > Andrey? I didn't find an update on this issue on LKML.
> > 
> > I'm pretty sure this is just a coincidence, an issue about how the kernel
> > image is actually layed out on your filesystem. I don't think it actually
> > has to do anything with the version.
> 
> Isn't the cause just that with that kernel the fs image is left unclean,

with all kernels. I don't think it changed from 2.6.19 to 2.6.19.1

> and grub has to replay the journal, which is slow ? 

Yes. But i think it depends on the actual disk layout _how slow_ it is :-)
-- 
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg  | "Well, surrounding them's out." 
