Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUCaVdi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 16:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262561AbUCaVcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 16:32:52 -0500
Received: from chaos.analogic.com ([204.178.40.224]:10885 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262574AbUCaVaF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 16:30:05 -0500
Date: Wed, 31 Mar 2004 16:31:29 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Chuck Lever <cel@citi.umich.edu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: timer question
In-Reply-To: <Pine.BSO.4.33.0403311609180.17377-100000@citi.umich.edu>
Message-ID: <Pine.LNX.4.53.0403311628120.12948@chaos>
References: <Pine.BSO.4.33.0403311609180.17377-100000@citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2004, Chuck Lever wrote:

> hi all-
>
> i'm looking for a way to do microsecond resolution timing in the RPC
> client.  i need a timer or timestamp function that is fairly cheap, that i
> can call on any hardware platform, and that i can invoke from inside a
> bottom half.
>
> any suggestions?
>
> 	- Chuck Lever

If you find one, we'd all like to use it!  The Intel machines,
after the i486, have the rdtsc instruction which will return
the number of CPU clocks that have occurred since the chip was
turned ON. It can be calibrated upon startup so you know how
many clocks occur in a second.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


