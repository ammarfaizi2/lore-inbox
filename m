Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135521AbRDZPUw>; Thu, 26 Apr 2001 11:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135516AbRDZPUl>; Thu, 26 Apr 2001 11:20:41 -0400
Received: from www.teaparty.net ([216.235.253.180]:34314 "EHLO
	www.teaparty.net") by vger.kernel.org with ESMTP id <S135513AbRDZPUd>;
	Thu, 26 Apr 2001 11:20:33 -0400
Date: Thu, 26 Apr 2001 16:20:25 +0100 (BST)
From: Vivek Dasmohapatra <vivek@etla.org>
To: Yiping Chen <YipingChen@via.com.tw>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: About rebuild 2.4.x kernel to support SMP.
In-Reply-To: <611C3E2A972ED41196EF0050DA92E0760265D56A@EXCHANGE2>
Message-ID: <Pine.LNX.4.10.10104261613220.3902-100000@www.teaparty.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2001, Yiping Chen wrote:

> My question is why the result of 'uname -r' is not "2.4.2-2smp" , but
> "2.4.2-2"

This is just the label as defined by the entries in the top-level
Makefile, eg:

VERSION = 2
PATCHLEVEL = 4
SUBLEVEL = 3
EXTRAVERSION = -ac5

> Whether I forgot to do something?

You can edit the extraversion value if you want to label your smp kernels
differently, but you don't have to.

You'll probably find you _have_ compiled an SMP kernel - see what
/proc/cpuinfo says, for example.

-- 
I am worthless. I struggle with the simple things. It seems so easy for 
everyone else. One armed blind people climb mountains and teenagers get
Ph.D's. I have trouble getting out of bed.
                                          -TMCM

