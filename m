Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264872AbRGFAd6>; Thu, 5 Jul 2001 20:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265646AbRGFAdr>; Thu, 5 Jul 2001 20:33:47 -0400
Received: from mcp.physics.ucsb.edu ([128.111.16.33]:49416 "EHLO
	mcp.physics.ucsb.edu") by vger.kernel.org with ESMTP
	id <S264872AbRGFAdh>; Thu, 5 Jul 2001 20:33:37 -0400
Date: Thu, 5 Jul 2001 17:33:36 -0700 (PDT)
From: David Whysong <dwhysong@physics.ucsb.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Re: __alloc_pages: 4-order allocation failed
Message-ID: <Pine.LNX.4.30.0107051730330.13297-100000@sal.physics.ucsb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen (jes@sunsite.dk) wrote:

>You ran out of memory, ie. there were no more free blocks of 16
>consecutive pages available in the system. This is what happens on a
>system with little memory or which is loaded with memory intensive
>applications.

I'm seeing the same thing here on a machine with 256 MB RAM and 1.5
gigabytes of swap. There is no chance I am using anywhere near that
much virtual memory.

Something is wrong with the MM in 2.4.6-pre9.

Dave

David Whysong                                       dwhysong@physics.ucsb.edu
Astrophysics graduate student         University of California, Santa Barbara
My public PGP keys are on my web page - http://www.physics.ucsb.edu/~dwhysong
DSS PGP Key 0x903F5BD6  :  FE78 91FE 4508 106F 7C88  1706 B792 6995 903F 5BD6
D-H PGP key 0x5DAB0F91  :  BC33 0F36 FCCD E72C 441F  663A 72ED 7FB7 5DAB 0F91

