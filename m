Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263263AbTC0QNI>; Thu, 27 Mar 2003 11:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263272AbTC0QNI>; Thu, 27 Mar 2003 11:13:08 -0500
Received: from borderworlds.dk ([62.79.110.124]:55567 "HELO
	klingon.borderworlds.dk") by vger.kernel.org with SMTP
	id <S263263AbTC0QNI>; Thu, 27 Mar 2003 11:13:08 -0500
To: linux-kernel@vger.kernel.org
Subject: / listed twice in /proc/mounts
From: Christian Laursen <xi@borderworlds.dk>
Date: 27 Mar 2003 17:24:11 +0100
Message-ID: <m3d6kcbwwk.fsf@borg.borderworlds.dk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The other day, I upgraded the components of a software package
that I maintain, including updating the kernel from 2.4.18 to
2.4.20.

I noticed something strange: / is now listed twice in /proc/mounts
like this

rootfs / rootfs rw 0 0
/dev/root / ext2 rw 0 0

It confused one of my scripts, so I had to implement a quick workaround.

Is this a feature or a bug?

-- 
Best regards
    Christian Laursen
