Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268388AbUHQSag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268388AbUHQSag (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 14:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268387AbUHQSag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 14:30:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:55517 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268388AbUHQSa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 14:30:26 -0400
Date: Tue, 17 Aug 2004 11:28:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, mochel@digitalimplant.org
Subject: Re: swsusp: fix default and merge upstream?
Message-Id: <20040817112843.1e3dae58.akpm@osdl.org>
In-Reply-To: <20040817180313.GD19009@elf.ucw.cz>
References: <20040817111128.GA4164@elf.ucw.cz>
	<20040817104745.683581dd.akpm@osdl.org>
	<20040817180313.GD19009@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> Hi!
> 
> > > Perhaps now is the right time to merge -mm swsusp up to Linus?
> > 
> > I suppose so.  The way to do that is for Pat to merge up the various
> > patches which are hanging around and then ask Linus to do the bk pull.
> 
> -mm plus two patches I sent today works pretty much okay.

OK.

> Are they
> swsusp-related things in your tree that are not in patrick's bk?

Just a couple of patches:

mm-swsusp-make-sure-we-do-not-return-to-userspace-where-image-is-on-disk.patch
mm-swsusp-copy_page-is-harmfull.patch

> driver-tree changes (enums etc) are pretty much orthogonal and can go
> in anytime later.
> 
> > What's the testing status of the new code in bk-power.patch?
> 
> Works for me, some users reported success (after being advised to use
> "shutdown" method), and suse pulled it into internal tree and it got
> basic testing there by Stefan. I guess that counts like "pretty well
> tested".

OK.  I'll integrate your most recent patches and will squirt everything at
Patrick.

