Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269528AbTGJS3w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 14:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269530AbTGJS3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 14:29:52 -0400
Received: from pop.gmx.de ([213.165.64.20]:7654 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269528AbTGJS3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 14:29:49 -0400
Date: Thu, 10 Jul 2003 21:44:29 +0300
From: Dan Aloni <da-x@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: auto-bk-get
Message-ID: <20030710184429.GA28366@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For kernel developers which are BitKeeper users, 

auto-bk-get is an on-demand 'bk get' libc wrapper tool.

It means that you don't need to run 'bk -r get' in order to build 
the kernel. Instead, you just run 'make config' or 'make bzImage', 
using auto-bk-get in a clean repository and auto-bk-get will 
only 'bk get' the files you need from the repository (one of my
test cases showed only 2800 out of 14000 files were checked out). 

It also supports building in an entirely different directory, 
taking the files from a repository somewhere else.

To download and compile auto-bk-get:

# bk clone http://auto-bk-get.bkbits.net/auto-bk-get
# cd auto-bk-get
# make

Read the README file.

-- 
Dan Aloni
da-x@gmx.net
