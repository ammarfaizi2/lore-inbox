Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbUKRCB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbUKRCB5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 21:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbUKRCBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 21:01:17 -0500
Received: from alog0084.analogic.com ([208.224.220.99]:31616 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262516AbUKQUlb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 15:41:31 -0500
Date: Wed, 17 Nov 2004 15:41:03 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Grzegorz Piotr Jaskiewicz <gj@kde.org.uk>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: pid_max madness
In-Reply-To: <419BB097.8030405@kde.org.uk>
Message-ID: <Pine.LNX.4.61.0411171538110.9491@chaos.analogic.com>
References: <419BB097.8030405@kde.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2004, Grzegorz Piotr Jaskiewicz wrote:

> Let's do:
> #echo "-1" >/proc/sys/kernel/pid_max
> #cat /proc/sys/kernel/pid_max
> -1
> #
>
> Madness, isn't ?
>
> I guess that isn't what author ment it to behave like.
> Anyway, does it mean that after max unsigned value is reached pids are going 
> to be negative in value ??
>
> --
> GJ
> -

Seems to set them back to 300 on this system Linux-2.6.9. That's
an interesting side-effect. I like it! They never get much over
300 either!


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
