Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbTFFSZi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 14:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbTFFSZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 14:25:38 -0400
Received: from wmail.atlantic.net ([209.208.0.84]:28594 "HELO
	wmail.atlantic.net") by vger.kernel.org with SMTP id S262169AbTFFSZi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 14:25:38 -0400
Message-ID: <3EE0E293.7080904@techsource.com>
Date: Fri, 06 Jun 2003 14:50:59 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bryan O'Sullivan" <bos@serpentine.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel printk format string compression: C syntax problem
References: <3EE0CF07.2070908@techsource.com> <1054922496.29652.12.camel@serpentine.internal.keyresearch.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Bryan O'Sullivan wrote:

> 
> 
> No.  Look at the __attribute__ on printk in include/linux/kernel.h.  GCC
> believes that printk takes a printf-style format string as its first
> argument, but you've mangled the string so that the number of format
> specifiers doesn't match the number of arguments.
> 


Oh!  So GCC is trying to be smart about printf format strings?  Cool. 
Never mind then.  :)

