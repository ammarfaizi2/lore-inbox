Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270367AbTGMTmj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 15:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270368AbTGMTmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 15:42:39 -0400
Received: from snickers.hotpop.com ([204.57.55.49]:7403 "EHLO
	snickers.hotpop.com") by vger.kernel.org with ESMTP id S270367AbTGMTmi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 15:42:38 -0400
Date: Mon, 14 Jul 2003 01:47:02 +0530
From: Niklaus <niklaus@gamebox.net>
To: aia21@cantab.net
Cc: ntfs@flatcap.org, linux-ntfs-dev@lists.sf.net,
       linux-kernel@vger.kernel.org
Subject: NTFS RW enabled
Message-Id: <20030714014702.4725a50c.niklaus@gamebox.net>
Organization: Gamebox
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I have enabled NTFS RW in kernel and compiled it as  a module.Everything went fine.
	I then loaded the module and mounted my win2k drive which is /dev/hda12.
	This is the output of mount 
	/dev/ide/host0/bus0/target0/lun0/part12 on /mnt/12 type ntfs (rw)
	As you can see /dev/hda12 or part12 is mounted rw.
	Even i tried this 
	/dev/ide/host0/bus0/target0/lun0/part12 on /mnt/12 type ntfs (rw,uid=0,umask=022)

	When i cd to /mnt/12 and do

	Foo:/mnt/12# ls
	RECYCLER
	System Volume Information
	Foo:/mnt/12# mkdir check
	mkdir: cannot create directory `check': Operation not permitted
	Foo:/mnt/12# touch try
	touch: cannot touch `try': Permission denied
	Foo:/mnt/12# echo hi > foo
	bash: foo: Permission denied
	Foo:/mnt/12# 
	Why aren't the commands working. I am sure i have enabled RW in kernel.I
        did it twice.
	kernel version is 2.4.21.
	
	What should i do to create a directory or file in NTFS drive (/mnt/12).
	Do i need special tools or how do i do it ?

Thank you
Nik

