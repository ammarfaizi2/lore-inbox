Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbUBYAKz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 19:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbUBYAKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 19:10:55 -0500
Received: from gprs144-166.eurotel.cz ([160.218.144.166]:54145 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262542AbUBYAKu (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 19:10:50 -0500
Date: Wed, 25 Feb 2004 01:10:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Coywolf Qi Hunt <coywolf@greatcn.org>, alan@lxorguk.ukuu.org.uk,
       Linux-Kernel@vger.kernel.org
Subject: Re: [PATCH] Fix GDT limit in setup.S for 2.0 and 2.2
Message-ID: <20040225001041.GD438@elf.ucw.cz>
References: <403114D9.2060402@lovecn.org> <403A07D8.5050704@greatcn.org> <20040223142120.GU17140@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040223142120.GU17140@khan.acc.umu.se>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I posted this problem days ago. Just now I check FreeBSD code and find 
> > theirs code goes no this problem. Please take my patches for 2.0 and 2.2
> > 2.4 patch have been already sent to Anvin.
> > 
> > (patches for 2.0 and 2.2 enclosed)
> 
> Thanks.  Note that I'm not due to release the first pre-patch for 2.0.41
> in another couple of months (unless some security issue surfaces)

I do not think that GDT change fixes any real bug. If I were you, I'd
reject it for 2.0.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
