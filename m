Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262762AbTCVMHL>; Sat, 22 Mar 2003 07:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262763AbTCVMHL>; Sat, 22 Mar 2003 07:07:11 -0500
Received: from packet.digeo.com ([12.110.80.53]:50660 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262762AbTCVMHK>;
	Sat, 22 Mar 2003 07:07:10 -0500
Date: Sat, 22 Mar 2003 04:17:58 -0800
From: Andrew Morton <akpm@digeo.com>
To: Jos Hulzink <josh@stack.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.65: oops: EIP at current_kernel_time +0x0f/0x40
Message-Id: <20030322041758.3ee1fed8.akpm@digeo.com>
In-Reply-To: <200303221252.12226.josh@stack.nl>
References: <200303221252.12226.josh@stack.nl>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Mar 2003 12:17:55.0081 (UTC) FILETIME=[11387790:01C2F06D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jos Hulzink <josh@stack.nl> wrote:
>
> Hi,
> 
> Here the early oops I'm stuck with in 2.5.65. Had to write it down manually, 
> so the report is not complete. If I missed something crucial, please ask. The 
> bug is easy to reproduce, so I can write anything down you need.
> 
> exact oops message scrolled away, console isn't set up yet, so I can't scroll 
> back.
> 
> EIP at current_kernel_time +0x0f/0x40
> 

That might be an lfence instruction.  I suspect you've chosen the wrong
CPU type?
