Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265762AbTL3LTy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 06:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265766AbTL3LTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 06:19:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:45009 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265762AbTL3LTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 06:19:53 -0500
Date: Tue, 30 Dec 2003 03:20:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Srikumar Subramanian <SrikumarS@ami.com>
Cc: linux-kernel@vger.kernel.org, SrikumarS@ami.com, BoopathiV@ami.com
Subject: Re: memory leak in call_usermodehelper()
Message-Id: <20031230032008.0783d4e8.akpm@osdl.org>
In-Reply-To: <8CCBDD5583C50E4196F012E79439B45C0568D7F0@atl-ms1.megatrends.com>
References: <8CCBDD5583C50E4196F012E79439B45C0568D7F0@atl-ms1.megatrends.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srikumar Subramanian <SrikumarS@ami.com> wrote:
>
> Hi All,
> 
> >From my customized system call, I merely call call_usermodehelper() to spawn
> a process. When I call my_system_call around 1000 times in order to spawn
> 'hello world' program, I noticed in 'top' program that system has lost 200
> KB of free memory.
> I just increased the iteration to 700000, I lost the entire 128 MB free
> memory from my system and eventually the system is freezed.
> 

What version of the kernel were you using?

