Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVGZAij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVGZAij (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 20:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbVGZAij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 20:38:39 -0400
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:18401 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S261572AbVGZAig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 20:38:36 -0400
Date: Mon, 25 Jul 2005 20:35:37 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Kernel cached memory
To: Bill Davidsen <davidsen@tmr.com>
Cc: Ashley <ashleyz@alchip.com>, lgb@lgb.hu,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>
Message-ID: <200507252038_MC3-1-A58B-D121@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2005 at 12:47:50 -0400, Bill Davidsen wrote:

> > It's a very - very - very old and bad logic (at least nowdays) from the
> > stone age to free up memory.
>
> It's very Microsoft to claim that the OS always knows best, and not let 
> the user tune the system the way they want it tuned.

Ironically, Microsoft offers a choice here.

In the registry (NT and W2K at least, don't know about XP:)

HKLM\SYSTEM\CurrentControlSet\Session Manager\Memory Management
        LargeSystemCache : REG_DWORD
                0: prefer application code over cached data
                1: prefer cached data

Also:

        DisablePagingExecutive : REG_DWORD
                1: don't allow kernel code to be paged out

        IOPageLockLimit : REG_DWORD
                controls the amount of memory that can be locked for I/O


__
Chuck
