Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133007AbRDZPyH>; Thu, 26 Apr 2001 11:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133095AbRDZPx6>; Thu, 26 Apr 2001 11:53:58 -0400
Received: from www.teaparty.net ([216.235.253.180]:35594 "EHLO
	www.teaparty.net") by vger.kernel.org with ESMTP id <S133076AbRDZPxk>;
	Thu, 26 Apr 2001 11:53:40 -0400
Date: Thu, 26 Apr 2001 16:48:38 +0100 (BST)
From: Vivek Dasmohapatra <vivek@etla.org>
To: Yiping Chen <YipingChen@via.com.tw>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: About rebuild 2.4.x kernel to support SMP.
In-Reply-To: <611C3E2A972ED41196EF0050DA92E0760265D56B@EXCHANGE2>
Message-ID: <Pine.LNX.4.10.10104261641580.3902-100000@www.teaparty.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2001, Yiping Chen wrote:

> So, I have two question now, 
> 1. how to determine whether your kernel support SMP?
>     Somebody taugh me that you can type  "uname -r", but it seems not
> correct.

Try:

cat /proc/stat

or

cat  /proc/cpuinfo

/proc/cpuinfo should contain 1 

processor       : N

line per processor.

/proc/stat will contain n cpuN lines, where n is the number of processors 
in your box, I think, or no such lines [just a cpu line] on a UP box.

-- 
There's an old proverb that says just about whatever you want it to.

