Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267743AbUI1NtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267743AbUI1NtF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 09:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267749AbUI1NtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 09:49:04 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:11081 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267743AbUI1Nrn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 09:47:43 -0400
Message-ID: <35fb2e5904092806477358b9b3@mail.gmail.com>
Date: Tue, 28 Sep 2004 14:47:42 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Ankit Jain <ankitjain1580@yahoo.com>
Subject: Re: processor affinity
Cc: linux <linux-kernel@vger.kernel.org>
In-Reply-To: <20040928122517.9741.qmail@web52907.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040928122517.9741.qmail@web52907.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2004 13:25:17 +0100 (BST), Ankit Jain
<ankitjain1580@yahoo.com> wrote:

> what is meant by processor affinity?

Affinity means that a process has an affinity for a particular subset
of the available CPUs within a particular system - it wishes to run
only on these processors. Linux supports hard processor affinity and
process migration to enforce such demands which get be made using the
POSIX sched_[set|get]param calls.

Robert Love has written an excellent book entitled Linux Kernel
Development, it's not expensive and very worthwhile. Chapter 3 is
entitled Scheduling and it explains process affinity as well as
process migration and the concept of migration threads as used within
the Linux kernel to enforce policy in the implmentation.

I suggest also that you consider joining the Kernel Newbies mailing
list, newly revived and now with working signup page over at
http://www.kernelnewbies.org/

Jon.
