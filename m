Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272508AbTHEPZM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 11:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272514AbTHEPZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 11:25:12 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7040 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S272508AbTHEPZI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 11:25:08 -0400
Date: Tue, 5 Aug 2003 11:24:54 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Viaris <bmeneses_beltran@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.0-test2 hang in Starting RedHat Network Daemon
In-Reply-To: <Law11-OE35phwFutJLt00010b17@hotmail.com>
Message-ID: <Pine.LNX.4.53.0308051121410.248@chaos>
References: <Law11-OE35phwFutJLt00010b17@hotmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003, Viaris wrote:

> Hi all
>
> I have problems with this new kernel, I compiled the 2.6.0-test2 but when
> start the services this kernel hang in the service starting RedHat Network,
> the message are:
>
> INIT:Id"1" respawning too fast: disabled for 5 minutes
> INIT:Id"2" respawning too fast: disabled for 5 minutes
> INIT:Id"3" respawning too fast: disabled for 5 minutes
> INIT:Id"4" respawning too fast: disabled for 5 minutes
> INIT:Id"5" respawning too fast: disabled for 5 minutes
> INIT:Id"6" respawning too fast: disabled for 5 minutes
> INIT:Id"4" respawning too fast: disabled for 5 minutes
> INIT: no more processes left in this runlevel.
>
> I have in my grub.conf the oher kernel version 2.4.20, If I start with this
> kernel, all work fine.
>
> How can I to resolv this problem with new kernel?
>
> Thanks in Advanced,
>
> Regards

Looks like your `gettys` were unable to open their virtual
terminals. So, you need to make sure that they are enabled
in your configuration. (UNIX98_PTYS=y), etc.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

