Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbVKIPUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbVKIPUS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 10:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbVKIPUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 10:20:18 -0500
Received: from www.swissdisk.com ([216.144.233.50]:39140 "EHLO
	swissweb.swissdisk.com") by vger.kernel.org with ESMTP
	id S1751055AbVKIPUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 10:20:16 -0500
Date: Wed, 9 Nov 2005 06:12:16 -0800
From: Ben Collins <ben.collins@ubuntu.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [ANNOUNCE] Ubuntu kernel tree
Message-ID: <20051109141216.GB30611@swissdisk.com>
References: <20051106013752.GA13368@swissdisk.com> <20051106202609.GA12481@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051106202609.GA12481@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2005 at 09:26:09PM +0100, Pavel Machek wrote:
> Hi!
> 
> > Some people may have noticed the new git tree located at:
> > 
> > rsync.kernel.org:/pub/scm/linux/kernel/git/bcollins/ubuntu-2.6.git
> > 
> > This tree will directly reflect the Ubuntu Linux Kernel that is available
> > in our distribution (along with build system). First use of this kernel
> > tree is slated for Dapper Drake (Ubuntu 6.04), and will stay synced with
> > the just released 2.6.14(.y).
> > 
> > There are several reasons for making this repo available on kernel.org.
> > Primary reasons include a more open development model, better visibility
> > with the kernel developer community, and to make the kernel available to
> > other distro's who may want to base their kernel off of ours.
> 
> Heh, I'm interested. We were thinking about using git for internal
> suse kernel trees, but we thought it would not work, as we need more
> something like quilt. Do you really use git internally, or do you just
> export to it? If git is usable for distro develompent... that would be
> good news. 

Prior to this we were using baz (arch derivative), but all the patches
were still applied at build time.

We're giving git a go just to see. It's all being done right there, I push
directly to master.kernel.org (and also mirror it to a local machine where
ubuntu devs can make better use of it).

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux
