Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263070AbVCXHBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263070AbVCXHBl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 02:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263072AbVCXHBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 02:01:40 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:61369 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S263070AbVCXHBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 02:01:14 -0500
Date: Thu, 24 Mar 2005 08:01:04 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Tom Vier <tmv@comcast.net>
cc: Pietro Zuco <maillist@zuco.org>, linux-kernel@vger.kernel.org
Subject: Re: Squashfs without ./..
In-Reply-To: <20050323174925.GA3272@zero>
Message-ID: <Pine.LNX.4.61.0503240800480.6309@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0503221645560.25571@yvahk01.tjqt.qr>
 <Pine.LNX.4.62.0503221656310.2683@dragon.hyggekrogen.localhost>
 <200503231740.09572.maillist@zuco.org> <Pine.LNX.4.61.0503231829570.1481@yvahk01.tjqt.qr>
 <20050323174925.GA3272@zero>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Which scripts use that? As stated, these two directory entries exist when you 
>> stat() them, they just do not show up in readdir(), and I bet few programs 
>> care for "." and ".." when doing their readdir.
>
>There's probably a number of apps that skip the first two dirents, instead
>of checking for the dot dirs.

Does POSIX or some standard say that . and .. need to be the first two 
entries?



Jan Engelhardt
-- 
