Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932624AbVJZOrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbVJZOrE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 10:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbVJZOrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 10:47:04 -0400
Received: from duero.optyma.com ([213.254.241.67]:56255 "EHLO duero.optyma.com")
	by vger.kernel.org with ESMTP id S932613AbVJZOrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 10:47:02 -0400
Subject: Problems with current file descriptor
From: Sergio Paracuellos <sparacuellos@lock-linux.com>
To: KERNEL-NEWBIE <linux-newbie@vger.kernel.org>,
       NUCLEO-DEVEL <nucleo-desarrollo@listas.hispalinux.es>,
       LINUX-KERNEL <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 26 Oct 2005 16:46:53 +0200
Message-Id: <1130338013.3344.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have problems to know whats is the current file descriptor. 

"task_struct" have a files_struct structure which contains all files for
a process in "fd". If I want to get the complete path for one of them,
How can I know what is the correct one in fd_array?

I suppose is something like:

path = d_path(task->files->fd[x]->f_dentry,
task->files->fd[x]->f_vfsmnt, buf, PAGE_SIZE);

But I don't know how to know this x for my correct file (for example the
last file I used).

Thanks in advance...

Cheers,
	Sergio

