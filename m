Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVGGNsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVGGNsy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 09:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVGGNrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 09:47:14 -0400
Received: from alog0361.analogic.com ([208.224.222.137]:42221 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261526AbVGGNpB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 09:45:01 -0400
Date: Thu, 7 Jul 2005 09:43:42 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: raja <vnagaraju@effigent.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: function Named
In-Reply-To: <42CD25FA.6030100@effigent.net>
Message-ID: <Pine.LNX.4.61.0507070939200.9975@chaos.analogic.com>
References: <42CD25FA.6030100@effigent.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2005, raja wrote:

> hi,
>    Is there any way to get the function address by only knowing the
> function Name
> thanking you,
> -

 	printf("%p\n", function());   // User code
 	printk("%p\n", function());   // Kernel code

This gives you the offset in virtual address-space. Inside the
kernel, one can obtain the physical address. User-code code
can't find out the physical address in any direct way.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
