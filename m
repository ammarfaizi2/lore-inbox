Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265140AbSLMQ47>; Fri, 13 Dec 2002 11:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265168AbSLMQ47>; Fri, 13 Dec 2002 11:56:59 -0500
Received: from 195-219-31-160.sp-static.linix.net ([195.219.31.160]:7808 "EHLO
	r2d2.office") by vger.kernel.org with ESMTP id <S265140AbSLMQ45>;
	Fri, 13 Dec 2002 11:56:57 -0500
Message-ID: <3DFA130C.1030106@walrond.org>
Date: Fri, 13 Dec 2002 17:04:12 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Symlink indirection
References: <3DF9F780.1070300@walrond.org> <mailman.1039792562.8768.linux-kernel2news@redhat.com> <200212131616.gBDGGH302861@devserv.devel.redhat.com> <3DFA0F6D.1010904@walrond.org> <20021213115508.A16493@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Of course; Didn't think of that in this context.

My application of symlinks involves overlaying several directories onto 
another, in an order such that any like named files are overridden in a 
defined way.

I had thought about asking the feasibility of [made up name] 
'transparent bindings' which would have this effect

Suppose I might as well ask now ;) Any takers?

Pete Zaitcev wrote:
>>Date: Fri, 13 Dec 2002 16:48:45 +0000
>>From: Andrew Walrond <andrew@walrond.org>
> 
> 
>>Sorry for being dense, but what do you mean by 'bindings' ? Hard links?
> 
> 
> $ man mount
> 
>        Since Linux 2.4.0 it is possible to remount part of the file  hierarchy
>        somewhere else. The call is
>               mount --bind olddir newdir
>        After this call the same contents is accessible in two places.
> 
> -- Pete
> 


