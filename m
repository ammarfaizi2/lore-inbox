Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265071AbTLWJ7Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 04:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265078AbTLWJ7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 04:59:15 -0500
Received: from [195.190.190.7] ([195.190.190.7]:55514 "EHLO mail.pixelized.ch")
	by vger.kernel.org with ESMTP id S265071AbTLWJ7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 04:59:14 -0500
Message-ID: <3FE811E3.6010708@debian.org>
Date: Tue, 23 Dec 2003 10:58:59 +0100
From: "Giacomo A. Catenazzi" <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Florian Weimer <fw@deneb.enyo.de>
CC: jw schultz <jw@pegasys.ws>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: SCO's infringing files list
References: <1072125736.1286.170.camel@duergar> <200312221519.04677.tcfelker@mtco.com> <Pine.LNX.4.58.0312221337010.6868@home.osdl.org> <20031223002641.GD28269@pegasys.ws> <20031223092847.GA3169@deneb.enyo.de>
In-Reply-To: <20031223092847.GA3169@deneb.enyo.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Florian Weimer wrote:

> jw schultz wrote:
> 
> 
>>And for the names, perhaps they would care to sue The Open
>>Group?
> 
> 
> Not the names, but the comments. 8-)
> 
> 
>>http://www.opengroup.org/onlinepubs/007904975/basedefs/errno.h.html
> 
> 
> The comments were added in Linux 0.99.1, and I'm not sure what was the
> source.  For example, Linux has:
> 
> #define ENOTTY          25      /* Not a typewriter */
> 
> Solaris:
> 
> #define ENOTTY  25      /* Inappropriate ioctl for device       */
> 
> Current POSIX:
> 
>     [ENOTTY]
>         Inappropriate I/O control operation.
> 
> I couldn't find any historic Minix header files.  Minix 2 has:
> 
> #define ENOTTY        (_SIGN 25)  /* inappropriate I/O control operation */

In 
http://www.opensource.apple.com/darwinsource/DevToolsMay2002/gcc-937.2/libiberty/strerror.c

/* Extended support for using errno values.
    Written by Fred Fish.  fnf@cygnus.com
    This file is in the public domain.  --Per Bothner.  */
(...)
#if defined (ENOTTY)
   ENTRY(ENOTTY, "ENOTTY", "Not a typewriter"),
#endif


FYI there was a proposed patch to change "Not a typewriter" to 
"Inappropriate ioctl for device". Check the interesting thread of lkml:
http://www.ussg.iu.edu/hypermail/linux/kernel/0105.1/0471.html

ciao
	giacomo


