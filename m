Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWHaPIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWHaPIw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 11:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWHaPIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 11:08:52 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13837 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932345AbWHaPIv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 11:08:51 -0400
Date: Thu, 31 Aug 2006 15:08:16 +0000
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, jeff.chua.linux@gmail.com
Subject: highmem64g vs. swsusp
Message-ID: <20060831150816.GA4106@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

> >Using a Lenovo T60 laptop - suspend to disk has always 
> >failed for me on resume.
> >
> >Through trial and error, I've found that this problem 
> >only occurs with
> >CONFIG_HIGHMEM64G (the default in a Fedora 
> >installation). On a couple of
> >occasions I've seen a hang or an oops instead of a 
> >reboot. Apologies for the
> >poor quality, but an image of the oops screen can be 
> >found at
> >http://www.dresco.co.uk/debug/resume_from_disk.jpg
> 
> I had the same problem on my IBM x60s. In my case, I see 
> no oops. Just
> reboot right after resume with CONFIG_HIGHMEM64G=y. 
> Turning off
> CONFIG_HIGHMEM64G, problem goes away. Don't know how to 
> fix. Just to
> confirm your findings. 2.6.18-rc5 has the same problem.

AFAIKK _all_ versions of swsusp have problem with highmem64g. I'll
need to bandaid it with config check for now.

-- 
Thanks for all the (sleeping) penguins.

-- 
Thanks for all the (sleeping) penguins.
