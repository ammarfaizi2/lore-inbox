Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbVBZAxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbVBZAxy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 19:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbVBZAxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 19:53:53 -0500
Received: from cantor.suse.de ([195.135.220.2]:1410 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262132AbVBZAxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 19:53:22 -0500
Date: Sat, 26 Feb 2005 01:53:21 +0100
From: Olaf Hering <olh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: 2.6.11-rc5
Message-ID: <20050226005321.GA26468@suse.de>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org> <20050224145049.GA21313@suse.de> <20050226004137.GA25539@suse.de> <Pine.LNX.4.58.0502251648420.9237@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502251648420.9237@ppc970.osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Feb 25, Linus Torvalds wrote:

> 
> 
> On Sat, 26 Feb 2005, Olaf Hering wrote:
> > 
> > modedb can not be __init because fb_find_mode() may get db == NULL.
> > fb_find_mode() is called from modules.
> 
> Ack. Maybe somebody should run the scripts again to check that we don't 
> reference __init data from non-init functions.

sparse doesnt do that, yet? (I never looked at it.)
