Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262611AbVF2Q4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbVF2Q4u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 12:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbVF2Q4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 12:56:50 -0400
Received: from alog0406.analogic.com ([208.224.222.182]:64457 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262613AbVF2Qwd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 12:52:33 -0400
Date: Wed, 29 Jun 2005 12:51:48 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Sreeni <sreeni.pulichi@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: **** How to lock memory pages?
In-Reply-To: <94e67edf050629083745bb4183@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0506291245170.22243@chaos.analogic.com>
References: <94e67edf05062810586d6141f3@mail.gmail.com>
 <m1br5p3ib8.fsf@ebiederm.dsl.xmission.com> <94e67edf050629083745bb4183@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2005, Sreeni wrote:

> Hi,
>
> Is there a way to lock a particular portion of the memory pages during
> kernel bootup? I want to re-use these pages when I load my
> application. I *don't* wanna use the idea of reserving some physical
> memory and using ioremap. I want something that kernel should be able
> to manage this memory but I don't want any other application to use
> this memory.
>
> Thanks in advance
> Sreeni
> -

Wrong kind of kernel for this kind of use. The kernel dynamically
allocates/deallocates/pages of memory that it knows about. The only
way to do what you want, with a kernel designed for multi-tasking
multi-user applications use, is to reserve memory during boot.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
