Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbVCZKDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVCZKDh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 05:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbVCZKDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 05:03:37 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:34768 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261712AbVCZKDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 05:03:36 -0500
Date: Sat, 26 Mar 2005 11:03:32 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Squashfs without ./..
In-Reply-To: <cce9e37e0503251948527d322b@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0503261059430.28431@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0503221645560.25571@yvahk01.tjqt.qr> 
 <20050323174925.GA3272@zero>  <Pine.LNX.4.62.0503241855350.18295@numbat.sonytel.be>
  <20050324133628.196a4c41.Tommy.Reynolds@MegaCoder.com>  <d1v67l$4dv$1@terminus.zytor.com>
  <3e74c9409b6e383b7b398fe919418d54@mac.com> <cce9e37e0503251948527d322b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>This situation is easily fixed within
>the application rather than forcing the filesystem to unnecessarily
>fake '.' and '..' entries which are never used.

You are right. . and .. do not need to show up (even they have been the 
"leaders" of ls -l ;-), Midnight Commander (`mc`) for example synthesizes ".." 
nevertheless.

So - what about removing . and .. in readdir for all "standard harddisk 
filesystems" (ext*,reiser*, [jx]fs)? I mean, one party always has to loose...


Jan Engelhardt
-- 
No TOFU for me, please.
