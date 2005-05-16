Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbVEPN7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVEPN7E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 09:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVEPN7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 09:59:04 -0400
Received: from alog0701.analogic.com ([208.224.223.238]:55195 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261662AbVEPN6l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 09:58:41 -0400
Date: Mon, 16 May 2005 09:58:25 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: linux <kernel@wired-net.gr>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 Kernel Threads
In-Reply-To: <002f01c55a1a$7c2cfda0$0101010a@dioxide>
Message-ID: <Pine.LNX.4.61.0505160956570.18329@chaos.analogic.com>
References: <002f01c55a1a$7c2cfda0$0101010a@dioxide>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2005, linux wrote:

> Hi all,
> can u tell how i can start/stop a kernel thread in 2.6.x series kernel???
>
>
> Thanks in advance.

You send it a signal. There are several drivers that use kernel threads.
You can see how they synchronize shut-down for module removal by
using a semaphone and a signal.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
