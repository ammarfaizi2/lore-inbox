Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129667AbRCCSzH>; Sat, 3 Mar 2001 13:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129666AbRCCSy5>; Sat, 3 Mar 2001 13:54:57 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:46813 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S129664AbRCCSyx>; Sat, 3 Mar 2001 13:54:53 -0500
Message-Id: <200103031945.f23JjSQ22763@513.holly-springs.nc.us>
Subject: Re: Q: How to get physical memory size from user space without proc
	fs
From: Michael Rothwell <rothwell@holly-springs.nc.us>
To: Denis Perchine <dyp@perchine.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10103031332480.11778-100000@mx.webmailstation.com>
Content-Type: text/plain
X-Mailer: Evolution (0.8/+cvs.2001.02.14.08.55 - Preview Release)
Date: 03 Mar 2001 14:55:54 -0500
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pyhsmem = `free | grep Mem | tr -s "/ / /" | cut -f2 -d" "`


On 03 Mar 2001 13:37:42 -0500, Denis Perchine wrote:
> Hello,
> 
> actually the question is in subj.
> Problem is that there is a program which needs to know physical memory
> size. This information is used to justify memory consumption as after some
> swapping performance is drops dramatically, and it is better to finish.
> 
> I know that this is not the best idea, but it is assumed that this program
> is the only one running on the machine.
> 
> I do not want to use proc as some people can just do not mount it.
> 
> Any comments, suggestions?
> 
> Thanks in advance.
> 
> Denis Perchine.
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

