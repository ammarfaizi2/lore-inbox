Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261467AbTCGKHx>; Fri, 7 Mar 2003 05:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261474AbTCGKHx>; Fri, 7 Mar 2003 05:07:53 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:31110 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S261467AbTCGKHw>; Fri, 7 Mar 2003 05:07:52 -0500
Date: Fri, 7 Mar 2003 10:20:12 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Steven Schaefer <sschaefer1@woh.rr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: mmap(.., .., PROT_READ, MAP_PRIVATE, .., ..) functionality
 question
In-Reply-To: <001f01c2e463$9e9ed5e0$de00000a@woh.rr.com>
Message-ID: <Pine.LNX.4.44.0303071019320.2236-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Mar 2003, Steven Schaefer wrote:
> 
> Doesn't mmap(), mind you with PROT_READ and MAP_PRIVATE, first copy the
> contents of the file into the swap space and then when the data is accessed
> into physical RAM before the CPU can get to it?

No, it does not copy the contents of the file into swap space.

Hugh

