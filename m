Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130507AbRCINpf>; Fri, 9 Mar 2001 08:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130512AbRCINpZ>; Fri, 9 Mar 2001 08:45:25 -0500
Received: from smtp.primusdsl.net ([209.225.164.93]:9740 "EHLO
	mailhost.digitalselect.net") by vger.kernel.org with ESMTP
	id <S130507AbRCINpO>; Fri, 9 Mar 2001 08:45:14 -0500
Date: Fri, 9 Mar 2001 08:46:17 -0500
From: James Lewis Nance <jlnance@intrex.net>
To: Manoj Sontakke <manojs@sasken.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: quicksort for linked list
Message-ID: <20010309084617.B1079@bessie.dyndns.org>
In-Reply-To: <3AA88891.294C17A0@sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3AA88891.294C17A0@sasken.com>; from manojs@sasken.com on Fri, Mar 09, 2001 at 01:08:57PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2001 at 01:08:57PM +0530, Manoj Sontakke wrote:
> Hi
> 	Sorry, these questions do not belog here but i could not find any
> better place.
> 
> 1. Is quicksort on doubly linked list is implemented anywhere? I need it
> for sk_buff queues.

I would suggest that you use merge sort.  It is ideally suited for sorting
linked lists, and it always has N log N running time.  I dont know of an
existing implementation in the kernel sources, but it should be easy to
write one.  I did a google search on "merge sort" "linked list" and it
comes up with lots of links.  Here is a good one:

    http://www.ddj.com/articles/1998/9805/9805p/9805p.htm?topic=java

Hope this helps,

Jim
