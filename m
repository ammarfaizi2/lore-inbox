Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277721AbRJIFBi>; Tue, 9 Oct 2001 01:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277720AbRJIFB2>; Tue, 9 Oct 2001 01:01:28 -0400
Received: from bacon.van.m-l.org ([208.223.154.200]:7552 "EHLO
	bacon.van.m-l.org") by vger.kernel.org with ESMTP
	id <S277721AbRJIFBR>; Tue, 9 Oct 2001 01:01:17 -0400
Date: Tue, 9 Oct 2001 01:01:47 -0400 (EDT)
From: George Greer <greerga@m-l.org>
X-X-Sender: <greerga@bacon.van.m-l.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Dave Jones <davej@suse.de>
Subject: Re: [PATCH] change name of rep_nop
In-Reply-To: <Pine.LNX.4.30.0110090120540.5479-100000@Appserv.suse.de>
Message-ID: <Pine.LNX.4.33.0110090059210.11296-100000@bacon.van.m-l.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001, Dave Jones wrote:

>On Tue, 9 Oct 2001, Alan Cox wrote:
>
>> That raises the question of whether x86 should seperate the "386" "486" ..
>> kernels by adding "Generic" for building a kernel that has all the work
>> arounds for everyones randomly buggy processors
>
>How do you propose to do this without turning setup.c and friends
>into a #ifdef nightmare ? setup_intel.c, setup_amd.c etc ??

I did a patch for that in the 2.2.x days that simply modified the existing
#ifdef's to be more specific.  The Configure file then set define_bool
options correctly for whatever option you chose. It was a very simple
strategy, but not a completely comprehensive patch.

-- 
George Greer, greerga@m-l.org
http://www.m-l.org/~greerga/

