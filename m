Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbVCWRt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbVCWRt3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 12:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbVCWRt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 12:49:29 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:14057 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261994AbVCWRt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 12:49:27 -0500
Date: Wed, 23 Mar 2005 12:49:25 -0500
From: Tom Vier <tmv@comcast.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Pietro Zuco <maillist@zuco.org>, linux-kernel@vger.kernel.org
Subject: Re: Squashfs without ./..
Message-ID: <20050323174925.GA3272@zero>
Reply-To: Tom Vier <tmv@comcast.net>
References: <Pine.LNX.4.61.0503221645560.25571@yvahk01.tjqt.qr> <Pine.LNX.4.62.0503221656310.2683@dragon.hyggekrogen.localhost> <200503231740.09572.maillist@zuco.org> <Pine.LNX.4.61.0503231829570.1481@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503231829570.1481@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 06:31:24PM +0100, Jan Engelhardt wrote:
> Which scripts use that? As stated, these two directory entries exist when you 
> stat() them, they just do not show up in readdir(), and I bet few programs 
> care for "." and ".." when doing their readdir.

There's probably a number of apps that skip the first two dirents, instead
of checking for the dot dirs.

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0x15741ECE
