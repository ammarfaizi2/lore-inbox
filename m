Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261398AbSJZOqz>; Sat, 26 Oct 2002 10:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261424AbSJZOqz>; Sat, 26 Oct 2002 10:46:55 -0400
Received: from norma.kjist.ac.kr ([203.237.41.18]:49543 "EHLO
	norma.kjist.ac.kr") by vger.kernel.org with ESMTP
	id <S261398AbSJZOqz>; Sat, 26 Oct 2002 10:46:55 -0400
Date: Sat, 26 Oct 2002 23:56:53 +0900 (KST)
From: Maintaniner on duty <hugh@norma.kjist.ac.kr>
To: <linux-kernel@vger.kernel.org>
Subject: IDESCSI emulation with 2.4.20-pre10aa1
Message-ID: <Pine.LNX.4.33.0210262343380.24144-100000@norma.kjist.ac.kr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I do not think this problem has anything to do with -aa1 patch.
Anyway, I tried to make a CDROM of an .iso file using a command
like

cdrecord -v dev=0,0 boot.iso

It correctly identified the cdrom in /dev/sr0
and strarted to write on the blank cd.
Well.. almost at the end of it, "data write error" appeared with
no reason.  The file size of the file "boot.iso" is just about 13M.
I then looked into the made cd, I could mount it.  Inside, everything
looked normal.

HOwever, when I tried to boot my machine with this CDROM, it showed
top of the familiar page.  But in the middle, it cannot finish
showing the whole page of SuSE-8.1 boot.iso page.

I suspect that in this particular kernel version, the idescsi emulation is
not bug-free, because I remember that there was a lot of communication
going on in kernel mailing list on this very topic.

Can someone point me a working kernel version for idescsi?

Thanks.


HUgh


