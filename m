Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281064AbRKDS1w>; Sun, 4 Nov 2001 13:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281069AbRKDS1m>; Sun, 4 Nov 2001 13:27:42 -0500
Received: from colorfullife.com ([216.156.138.34]:52750 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S281085AbRKDS1d>;
	Sun, 4 Nov 2001 13:27:33 -0500
Message-ID: <3BE58883.844058@colorfullife.com>
Date: Sun, 04 Nov 2001 19:27:15 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.14-pre7 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: [CFT][PATCH] ramfs/tmpfs readdir()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> 
> Note that other filesystems would already enjoy having a d_offset in the
> dentry: it allows for various other optimizations (ie making "unlink()" a
> O(1) operation, by not having to search the directory).
> 
The dentry structure already contains 2 members for filesystem use
(d_time and d_fsdata), is a third member really required?

--
	Manfred
