Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278481AbRJVKOX>; Mon, 22 Oct 2001 06:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278482AbRJVKON>; Mon, 22 Oct 2001 06:14:13 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:9282 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S278481AbRJVKOK>; Mon, 22 Oct 2001 06:14:10 -0400
Date: Mon, 22 Oct 2001 12:01:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: 2.4.13pre5aa1
Message-ID: <20011022120113.K8408@athlon.random>
In-Reply-To: <20011020194024.C10680@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011020194024.C10680@in.ibm.com>; from maneesh@in.ibm.com on Sat, Oct 20, 2001 at 07:40:24PM +0530
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2001 at 07:40:24PM +0530, Maneesh Soni wrote:
> 
> In article <20011019061914.A1568@athlon.random> you wrote:
> 
> > Only in 2.4.13pre3aa1: 00_files_struct_rcu-2.4.10-04-1
> > Only in 2.4.13pre5aa1: 00_files_struct_rcu-2.4.10-04-2
> 
> Hello Andrea,
>  
> Please apply the following update for the rcu fd patch.
> This has fixes for two more bugs pointed by Dipankar.
>  
> 1. fs/file.c
>         in expand_fd_array new_fds is not freed if allocation for arg fails.
>  
> 2. fs/file.c
>         kmalloc for arg instead of *arg in expand_fd_array and expand_fdset

thanks for the update!! Applied.

Andrea
