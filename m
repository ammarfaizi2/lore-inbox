Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266561AbUJVTHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266561AbUJVTHu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 15:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266319AbUJVTDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 15:03:13 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2176 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266561AbUJVTB5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 15:01:57 -0400
Date: Fri, 22 Oct 2004 15:01:56 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Arvind Kalyan <base16@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: GPRS on Linux fails due to 255.255.255.255 remote address.
In-Reply-To: <90c25f2704102211212031af71@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0410221454370.6012@chaos.analogic.com>
References: <90c25f2704102211212031af71@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004, Arvind Kalyan wrote:

> Hi,
>
> I'm trying to use my Airtel GPRS connection under Linux.
>

According to the documentation I've been reading, you set
up your computer for DHCP! It will automatically use one
of those free 192.x.x.x addresses to start if you
don't already have an ISP connection. Otherwise, you
leave your current configuration alone and the ppp link
will work as a remote system.


In no case should an IP address be 255.255.255.255.


> a. modem initialization strings
> b. authentication type : pap
> c. remote IP address: 255.255.255.255
> d. gateway address: my own IP is made my gw (10.*.*.*)
> e. name servers: automatically assigned numbers...
>
> 2. Rebooted into Linux
>

[SNIPPED...]

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 GrumpyMips).
                  98.36% of all statistics are fiction.
