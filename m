Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269783AbTGKFLH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 01:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269789AbTGKFLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 01:11:06 -0400
Received: from pop.gmx.net ([213.165.64.20]:41401 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269783AbTGKFLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 01:11:00 -0400
Date: Fri, 11 Jul 2003 08:25:39 +0300
From: Dan Aloni <da-x@gmx.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: auto-bk-get
Message-ID: <20030711052539.GA9586@callisto.yi.org>
References: <20030710184429.GA28366@callisto.yi.org> <3F0DD5F6.5060302@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F0DD5F6.5060302@pobox.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 05:09:10PM -0400, Jeff Garzik wrote:
> Dan Aloni wrote:
> >For kernel developers which are BitKeeper users, 
> >
> >auto-bk-get is an on-demand 'bk get' libc wrapper tool.
> >
> >It means that you don't need to run 'bk -r get' in order to build 
> >the kernel. Instead, you just run 'make config' or 'make bzImage', 
> >using auto-bk-get in a clean repository and auto-bk-get will 
> >only 'bk get' the files you need from the repository (one of my
> >test cases showed only 2800 out of 14000 files were checked out). 
> 
> 
> No offense, but, it would probably be easier to fix the few remaining 
> places where the makefile system does not automatically check out the files.
> 
> It works great for everything except the Kconfig stuff, IIRC.

It's not just that. Does make and the build system alone allow you 
to build in an entirely different tree? (i.e check out and recreate
the directory structure somewhere else, leaving the repository clean or
even on a read-only media).

-- 
Dan Aloni
da-x@gmx.net
