Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbUKANQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbUKANQl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 08:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbUKANQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 08:16:41 -0500
Received: from wine.ocn.ne.jp ([220.111.47.146]:56298 "EHLO
	smtp.wine.ocn.ne.jp") by vger.kernel.org with ESMTP id S261769AbUKANQe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 08:16:34 -0500
To: ks@cs.aau.dk, linux-kernel@vger.kernel.org
Subject: Re: [RFC][2.4 PATCH] A restricted /dev filesystem.
From: Tetsuo Handa <from-linux-kernel@i-love.sakura.ne.jp>
References: <200411012114.IIG42981.tSSMNOFVtPMYFGLOJ@i-love.sakura.ne.jp>
	<200411011343.00513.ks@cs.aau.dk>
In-Reply-To: <200411011343.00513.ks@cs.aau.dk>
Message-Id: <200411012216.DJJ13206.JFtSVOLtOSPMNFYGM@i-love.sakura.ne.jp>
X-Mailer: Winbiff [Version 2.43]
X-Accept-Language: ja,en
Date: Mon, 1 Nov 2004 22:16:31 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Kristian.

Thank you for your advise.

But this is 2.4, which LSM isn't integrated into.
Also, I have experienced the difficulty of managing SELinux's policy.
I agree what I want to do can be done with LSM,
but I want more simpler approach.

Thank you.

In message <200411011343.00513.ks@cs.aau.dk>
   "Re: [RFC][2.4 PATCH] A restricted /dev filesystem."
   "<ks@cs.aau.dk>" wrote:

> E.g. these two statements of disallowing creation of hardlinks and regular 
> files in /dev can easily be implemented as a LSM module (see 
> include/linux/security.h). (I think) You will need to consider the hooks 
> inode_create and inode_link only.
