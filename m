Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263526AbTJLU0L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 16:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263527AbTJLU0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 16:26:11 -0400
Received: from web20410.mail.yahoo.com ([66.163.169.98]:58547 "HELO
	web20422.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263526AbTJLU0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 16:26:10 -0400
Message-ID: <20031012202609.54340.qmail@web20422.mail.yahoo.com>
Date: Sun, 12 Oct 2003 13:26:09 -0700 (PDT)
From: kevin conaway <kconaway_is@yahoo.com>
Subject: Where does user_path_walk() live?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am a student doing an independent study on
filesystem security and I was trying to pin down
exactly where a users permissions are checked when
trying to access a particular file.  Looking through
the various system calls in /usr/src/linux/fs/open.c
tells me that each call that requires a permission
check calls user_path_walk() to essentially "walk"
through the parts of the path to make sure the sure
has access to each part.  I attempted to find the code
for user_path_walk() but all I could find was a
#define statement that showed user_path_walk was
really a macro for __user_walk().  All I could find
were symbol references for __user_walk() in the kernel
tree.  Does anyone know where this code lives?

Thanks

Kevin Conaway

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
