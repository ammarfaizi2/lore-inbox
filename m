Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266469AbTGJUyw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 16:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269569AbTGJUyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 16:54:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39378 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266469AbTGJUyv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 16:54:51 -0400
Message-ID: <3F0DD5F6.5060302@pobox.com>
Date: Thu, 10 Jul 2003 17:09:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Aloni <da-x@gmx.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: auto-bk-get
References: <20030710184429.GA28366@callisto.yi.org>
In-Reply-To: <20030710184429.GA28366@callisto.yi.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Aloni wrote:
> For kernel developers which are BitKeeper users, 
> 
> auto-bk-get is an on-demand 'bk get' libc wrapper tool.
> 
> It means that you don't need to run 'bk -r get' in order to build 
> the kernel. Instead, you just run 'make config' or 'make bzImage', 
> using auto-bk-get in a clean repository and auto-bk-get will 
> only 'bk get' the files you need from the repository (one of my
> test cases showed only 2800 out of 14000 files were checked out). 


No offense, but, it would probably be easier to fix the few remaining 
places where the makefile system does not automatically check out the files.

It works great for everything except the Kconfig stuff, IIRC.

	Jeff



