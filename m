Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273269AbRJTOCs>; Sat, 20 Oct 2001 10:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273305AbRJTOCi>; Sat, 20 Oct 2001 10:02:38 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:19340 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S273269AbRJTOC1>; Sat, 20 Oct 2001 10:02:27 -0400
Date: Sat, 20 Oct 2001 19:40:24 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: andrea@suse.de
Cc: LKML <linux-kernel@vger.kernel.org>, Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: 2.4.13pre5aa1
Message-ID: <20011020194024.C10680@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In article <20011019061914.A1568@athlon.random> you wrote:

> Only in 2.4.13pre3aa1: 00_files_struct_rcu-2.4.10-04-1
> Only in 2.4.13pre5aa1: 00_files_struct_rcu-2.4.10-04-2

Hello Andrea,
 
Please apply the following update for the rcu fd patch.
This has fixes for two more bugs pointed by Dipankar.
 
1. fs/file.c
        in expand_fd_array new_fds is not freed if allocation for arg fails.
 
2. fs/file.c
        kmalloc for arg instead of *arg in expand_fd_array and expand_fdset
 
Thank you,
Maneesh

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5262355 Extn. 3999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/locking/rcupdate.html

