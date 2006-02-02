Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423455AbWBBKs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423455AbWBBKs5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 05:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423456AbWBBKs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 05:48:56 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22965 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1423455AbWBBKs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 05:48:56 -0500
Date: Thu, 2 Feb 2006 11:48:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060202104845.GD1884@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060202100522.GB1981@elf.ucw.cz> <200602022038.16262.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200602022038.16262.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 02-02-06 20:38:11, Nigel Cunningham wrote:
> Hi.
> 
> On Thursday 02 February 2006 20:05, Pavel Machek wrote:
> > Hi!
> >
> > > This set of patches represents the core of Suspend2's module support.
> > >
> > > Suspend2 uses a strong internal API to separate the method of
> > > determining the content of the image from the method by which it is
> > > saved. The code for determining the content is part of the core of
> > > Suspend2, and transformations (compression and/or encryption) and storage
> > > of the pages are handled by 'modules'.
> >
> > swsusp already has a very strong API to separate image writing from
> > image creation (in -mm patch, anyway). It is also very nice, just
> > read() from /dev/snapshot. Please use it.
> 
> You know that's not an option.

(You could even use /dev/snapshot from kernelspace... for tests or
something. But such patch is not going to be mergeable.)
							Pavel
-- 
Thanks, Sharp!
