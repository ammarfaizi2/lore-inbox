Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269926AbTGKMch (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 08:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269922AbTGKM3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 08:29:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59339 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269915AbTGKM31
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 08:29:27 -0400
Message-ID: <3F0EB10E.6070500@pobox.com>
Date: Fri, 11 Jul 2003 08:43:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Aloni <da-x@gmx.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: auto-bk-get
References: <20030710184429.GA28366@callisto.yi.org> <3F0DD5F6.5060302@pobox.com> <20030711052539.GA9586@callisto.yi.org>
In-Reply-To: <20030711052539.GA9586@callisto.yi.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Aloni wrote:
> On Thu, Jul 10, 2003 at 05:09:10PM -0400, Jeff Garzik wrote:
> 
>>Dan Aloni wrote:
>>
>>>For kernel developers which are BitKeeper users, 
>>>
>>>auto-bk-get is an on-demand 'bk get' libc wrapper tool.
>>>
>>>It means that you don't need to run 'bk -r get' in order to build 
>>>the kernel. Instead, you just run 'make config' or 'make bzImage', 
>>>using auto-bk-get in a clean repository and auto-bk-get will 
>>>only 'bk get' the files you need from the repository (one of my
>>>test cases showed only 2800 out of 14000 files were checked out). 
>>
>>
>>No offense, but, it would probably be easier to fix the few remaining 
>>places where the makefile system does not automatically check out the files.
>>
>>It works great for everything except the Kconfig stuff, IIRC.
> 
> 
> It's not just that. Does make and the build system alone allow you 
> to build in an entirely different tree? (i.e check out and recreate
> the directory structure somewhere else, leaving the repository clean or
> even on a read-only media).


Yes, that's Sam Ravnborg's (sp?) srcdir != objdir work.

	Jeff



