Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262102AbVAJGHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbVAJGHf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 01:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVAJGGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 01:06:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:26068 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262102AbVAJGEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 01:04:25 -0500
Message-ID: <41E21957.7030406@osdl.org>
Date: Sun, 09 Jan 2005 21:57:43 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: selvakumar nagendran <kernelselva@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Pipefs : doubts
References: <20050110050450.51158.qmail@web60608.mail.yahoo.com>
In-Reply-To: <20050110050450.51158.qmail@web60608.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

selvakumar nagendran wrote:
> Hello linux-experts,
>     I went through the kernel source code file
> /fs/pipe.c and I found that the pipe file system
> configured as a module. But in lsmod I am unable to
> see it. This is my first doubt.

Where do you see that?
fs/pipe.o is always built into the kernel image.

>     My second doubt is, in pipe.c we have lot of
> symbols like 
> 
>   PIPE_WAITING_READERS(*inode)
>   PIPE_WAIT(*inode)
>   PIPE_MAX_RCHUNK(*inode)
>    What are they? funtions or macros? What they do or
> where are their implementation in the kernel source
> tree?

Macros.
See include/linux/pipe_fs_i.h

-- 
~Randy
