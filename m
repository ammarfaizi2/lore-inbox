Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278309AbRJSFMU>; Fri, 19 Oct 2001 01:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278310AbRJSFMK>; Fri, 19 Oct 2001 01:12:10 -0400
Received: from smtpsrv1.isis.unc.edu ([152.2.1.138]:46530 "EHLO
	smtpsrv1.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S278309AbRJSFMB>; Fri, 19 Oct 2001 01:12:01 -0400
Date: Fri, 19 Oct 2001 01:12:25 -0400 (EDT)
From: "Daniel T. Chen" <crimsun@email.unc.edu>
To: safemode <safemode@speakeasy.net>
cc: Davide Libenzi <davidel@xmailserver.org>,
        "David E. Weekly" <dweekly@legato.com>,
        ML-linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Compile in tmpfs crumples in 2.4.12 w/epoll patch
In-Reply-To: <20011019012601Z278266-17408+2209@vger.kernel.org>
Message-ID: <Pine.A41.4.21L1.0110190111090.59346-100000@login3.isis.unc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bug in yesterday's build of binutils (2.11.92.0.5-3), which is fixed in
today's build (2.11.92.0.7-1).

---
Dan Chen                 crimsun@email.unc.edu
GPG key: www.cs.unc.edu/~chenda/pubkey.gpg.asc

On Thu, 18 Oct 2001, safemode wrote:

> It works fine here, cept i get that damn 
> ld: bvmlinux: Not enough room for program headers (allocated 2, need 3)
> ld: final link failed: Bad value
> error now when i compile on tmpfs that i didn't get when i compiled on the 
> hdd with 2.4.10-acX.  It's only started happening since using 2.4.12-ac3.  
> I've only used this kernel so i dont know if it's 2.4.12 or the ac3 part.   
> anyways it got to that point in about 3:30 seconds . . which is about 5 
> seconds faster than disk.   

