Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282375AbRKXGh7>; Sat, 24 Nov 2001 01:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282378AbRKXGht>; Sat, 24 Nov 2001 01:37:49 -0500
Received: from coleridge.kublai.com ([207.96.1.116]:59798 "HELO
	mailhost.kublai.com") by vger.kernel.org with SMTP
	id <S282376AbRKXGhn>; Sat, 24 Nov 2001 01:37:43 -0500
Date: Sat, 24 Nov 2001 01:36:42 -0500 (EST)
From: Kyle Sallee <cromwell@kublai.com>
To: <linux-kernel@vger.kernel.org>
Subject: loopback filesystems broke in 2.4.15
Message-ID: <Pine.GSO.4.33.0111240127140.17247-100000@coleridge.kublai.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a script that works with all previous linux versions that creates
an initrd.  When I ran it in 2.4.15 the initrd that was created was
as empty of files as it was when I did a mkfs on it.  This bug is
repeatable.

dd a file, attach it to a loop, mkfs it, mount it, cp some files to it,
unmount it, detach it from the loop, reatach it to the lop, remount it,
and it is empty.

Please cc replies to me since I am not on the list.

