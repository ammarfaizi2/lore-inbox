Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266103AbRGPExt>; Mon, 16 Jul 2001 00:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266097AbRGPEx3>; Mon, 16 Jul 2001 00:53:29 -0400
Received: from tahallah.demon.co.uk ([158.152.175.193]:12804 "EHLO
	tahallah.demon.co.uk") by vger.kernel.org with ESMTP
	id <S266104AbRGPExT>; Mon, 16 Jul 2001 00:53:19 -0400
Date: Mon, 16 Jul 2001 05:50:12 +0100 (BST)
From: Alex Buell <alex.buell@tahallah.demon.co.uk>
X-X-Sender: <alex@tahallah.demon.co.uk>
Reply-To: <alex.buell@tahallah.demon.co.uk>
To: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Duplicate '..' in /lib 
Message-ID: <Pine.LNX.4.33.0107160548400.3655-100000@tahallah.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just found a pair of '..' directories in the /lib directory. e2fsck 1.19
didn't even pick up on this!

/lib
   4 drwxr-xr-x   19 root     root         4096 Jun  9 16:06 ..
   4 -rw-rw-r--    1 root     root           27 Jun  9 15:55 ..

How can I get rid of this? I'm on kernel 2.2.19, running on sparc-linux.

-- 
Hey, they *are* out to get you, but it's nothing personal.

http://www.tahallah.demon.co.uk

