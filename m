Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265796AbRGCSwP>; Tue, 3 Jul 2001 14:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265789AbRGCSwF>; Tue, 3 Jul 2001 14:52:05 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:57307 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265902AbRGCSvw>; Tue, 3 Jul 2001 14:51:52 -0400
Date: Tue, 3 Jul 2001 11:51:39 -0700
From: Mike Kravetz <mkravetz@sequent.com>
To: Sasha Pachev <sasha@mysql.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange thread behaviour on 8-way x86 machine
Message-ID: <20010703115139.B1128@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <0107031225120K.18621@mysql>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <0107031225120K.18621@mysql>; from sasha@mysql.com on Tue, Jul 03, 2001 at 12:25:12PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2001 at 12:25:12PM -0600, Sasha Pachev wrote:
> Hi,
> 
> I have observed a rather strange behaviour doing a multi-threaded CPU 
> benchmark on an 8-way machine running 2.4.2 SMP kernel. Even when the 
> priority is reniced to the highest possible value, I am still unable to reach 
> more than 50% CPU utilization. My benchmark just creates a bunch of threads 
> with pthread_create(), and then runs a simple integer computation in each 
> thread. On a dual with 2.4.3 kernel, and a 4-way with 2.4.2 kernel, I am able 
> to reach full CPU utilization. 

I haven't had any problem fully utilizing 8 CPUs on 2.4.* kernels.  This
may seem obvious, but do you have more than 4 CPUs worth of work for the
system to do?  What is the runqueue length during this benchmark?

-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
