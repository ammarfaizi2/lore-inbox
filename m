Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbVH0U7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbVH0U7z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 16:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVH0U7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 16:59:55 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:61867 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1750782AbVH0U7y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 16:59:54 -0400
Subject: Re: [PATCH ISDN] Fix capifs bug in initialization error path.
From: Marcel Holtmann <marcel@holtmann.org>
To: Karsten Keil <kkeil@suse.de>
Cc: James Morris <jmorris@namei.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, kai.germaschewski@gmx.de, akpm@osdl.org
In-Reply-To: <20050827114706.GB860@pingi3.kke.suse.de>
References: <Pine.LNX.4.63.0508262339210.21123@excalibur.intercode>
	 <20050827114706.GB860@pingi3.kke.suse.de>
Content-Type: text/plain
Date: Sat, 27 Aug 2005 22:59:35 +0200
Message-Id: <1125176375.14395.5.camel@blade>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karsten,

> > This patch fixes a bug in the capifs initialization code, where the 
> > filesystem is not unregistered if kern_mount() fails.
> > 
> > Please apply.
> 
> looks OK for me.

and what about me idea to remove capifs completely? We have udev now and
thus it is not needed anymore. I stopped compiling and using it a long
time ago.

Regards

Marcel


