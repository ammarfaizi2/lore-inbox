Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135973AbREBVJd>; Wed, 2 May 2001 17:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135940AbREBVIF>; Wed, 2 May 2001 17:08:05 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:31500 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135908AbREBVHI>; Wed, 2 May 2001 17:07:08 -0400
Date: Wed, 2 May 2001 16:27:41 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Jorge Nerin <comandante@zaralinux.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux SMP <linux-smp@vger.kernel.org>
Subject: Re: Memory management issues with 2.4.4
In-Reply-To: <3AF02049.1080901@zaralinux.com>
Message-ID: <Pine.LNX.4.21.0105021625520.4127-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 May 2001, Jorge Nerin wrote:

> Short version:
> Under very heavy thrashing (about four hours) the system either lockups 
> or OOM handler kills a task even when there is swap space left.

First of all, please try to reproduce the problem with 2.4.5-pre1. 

If it still happens with pre1, please show us the output of "cat
/proc/slabinfo" when the kernel is about to trigger the OOM killer.

Thanks.



