Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314058AbSEHNmm>; Wed, 8 May 2002 09:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314223AbSEHNml>; Wed, 8 May 2002 09:42:41 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:17672 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314058AbSEHNmk>;
	Wed, 8 May 2002 09:42:40 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Dax Kelson <dax@gurulabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Completely honor prctl(PR_SET_KEEPCAPS, 1) 
In-Reply-To: Your message of "Wed, 08 May 2002 03:40:11 CST."
             <Pine.LNX.4.44.0205080136560.8607-100000@mooru.gurulabs.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 08 May 2002 23:42:29 +1000
Message-ID: <9176.1020865349@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2002 03:40:11 -0600 (MDT), 
Dax Kelson <dax@gurulabs.com> wrote:
>Originally when a process set*uided all capabilities bits were cleared.  
>Then sometime later (wish BK went back 3 years), the behaviour was
>modified according to the comment "A process may, via prctl(), elect to
>keep its capabilites when it calls setuid() and switches away from
>uid==0. Both permitted and effective sets will be retained."

FWIW, the change was in 2.2.18-pre18, between October 26 and 29, 2000.

I have all the kernel versions from 2.0.21 (1997) through 2.5.14 in a
set of PRCS repositories.  A binary chop on 2.2 found the change in a
few minutes.

