Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbUBXE6i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 23:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262167AbUBXE6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 23:58:38 -0500
Received: from jivdhan.unipune.ernet.in ([196.1.114.23]:44502 "EHLO
	jivdhan.unipune.ernet.in") by vger.kernel.org with ESMTP
	id S262159AbUBXE6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 23:58:36 -0500
Message-ID: <005601c3fd75$1c681510$8c01080a@crayii>
From: "Gautam Pagedar" <gautam@cins.unipune.ernet.in>
To: <linux-kernel@vger.kernel.org>
Subject: can i modify ls
Date: Sat, 28 Feb 2004 02:33:00 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MIMEOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Everyboy.
   i am new to this mailing list, so please bear with me if i don't follow
certain rules till i get used to it.  I am a research student and currently
working on a project to tweak the working of 'ls' command depending on my
requirement. I have observed that 'ls' show ALL THE FILES and DIRECTORIES in
a particular location even though a user has no access rights to it. I want
to hide all
such files for that particular user.

The Algorithm i beleive should work like this when an 'ls' command is
called.

1. Check the current directory.
2. Extract the files or directory to be displayed.
3. Check the user permissions for these files.
4. Display only those files wher user had either read, write or execute
access for all owner,group and others.

I have found out that 'ls' uses getdents64() system call for gathering the
directory information. How do i move ahead from here.

Regards,
Gautam Pagedar
Centre for Information and Network Security










