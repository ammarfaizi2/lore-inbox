Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161152AbWG1Nym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161152AbWG1Nym (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 09:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161153AbWG1Nym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 09:54:42 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26376 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1161152AbWG1Nym
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 09:54:42 -0400
Date: Fri, 28 Jul 2006 13:54:29 +0000
From: Pavel Machek <pavel@ucw.cz>
To: liyu <liyu@ccoss.com.cn>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Peter <peter@maubp.freeserve.co.uk>,
       The Doctor <thedoctor@tardis.homelinux.org>
Subject: Re: [PATCH 1/3] usbhid: Driver for microsoft natural ergonomic keyboard 4000
Message-ID: <20060728135428.GC4623@ucw.cz>
References: <44C74708.6090907@ccoss.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C74708.6090907@ccoss.com.cn>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>     This new version get some improvements:
> 
>     2. Support left paren key "(", right paren key ")", equal key "=" on
> right-top keypad. In fact, this keyboard generate KEYPAD_XXX usage code
> for them, but I find many applications can not handle them on default
> configuration, especially X.org. To get the most best usability, I use a
> bit magic here: map them to "Shift+9" and "Shift+0".

That is hardly 'improvement'. 'X is broken, so lets break input, too'.



-- 
Thanks for all the (sleeping) penguins.
