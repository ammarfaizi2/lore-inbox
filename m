Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261335AbSIZTk7>; Thu, 26 Sep 2002 15:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261466AbSIZTk6>; Thu, 26 Sep 2002 15:40:58 -0400
Received: from ptldme-smtp2.maine.rr.com ([204.210.65.67]:57060 "EHLO
	ptldme-mls2.maine.rr.com") by vger.kernel.org with ESMTP
	id <S261335AbSIZTk6>; Thu, 26 Sep 2002 15:40:58 -0400
Message-ID: <3D9364C5.9060208@maine.rr.com>
Date: Thu, 26 Sep 2002 15:49:25 -0400
From: "David B. Stevens" <dsteven3@maine.rr.com>
Organization: Penguin Preservation Society
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Thunder from the hill <thunder@lightweight.ods.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Single linked lists for Linux, overly complicated
 v2
References: <Pine.LNX.4.44L.0209261628490.1837-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik,

I respectfully disagree, it is well known that systems are far more 
stable when running on empty lists, routines like this get us there faster.

Cheers,
   Dave

PS:Is it April in September?



Rik van Riel wrote:
> On Thu, 26 Sep 2002, Thunder from the hill wrote:
> 
> 
>>We don't know the parent structure. We shouldn't know it, since it takes
>>time. So I try to keep the address pointer stable instead of just
>>exchanging pointers.
> 
> 
> In the case of slist_del() you HAVE to know it.
> 
> Think about removing a single entry from the middle of
> the list ... the entries before and after need to stay
> on the list.
> 
> Rik


