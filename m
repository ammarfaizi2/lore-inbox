Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262541AbVESPSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbVESPSz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 11:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbVESPSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 11:18:55 -0400
Received: from alog0469.analogic.com ([208.224.222.245]:10414 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262541AbVESPSt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 11:18:49 -0400
Date: Thu, 19 May 2005 11:18:22 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: linux <kernel@wired-net.gr>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 Kernel thread start/stop
In-Reply-To: <001c01c55c83$1df6ec80$0101010a@dioxide>
Message-ID: <Pine.LNX.4.61.0505191117150.30623@chaos.analogic.com>
References: <001c01c55c83$1df6ec80$0101010a@dioxide>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2005, linux wrote:

> Hi all,
> i am starting from inside a module a kernel thread*,but in some time later
> i
> want to remove that module and stop the thread.
> What is the process while unloading a module to release a kernel thread in
> 2.4.x kernel series.?????
>
> Thanks in advance.

Look at code that uses kernel threads. You send the task a signal
and synchronize its exit with a semaphore.



Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
