Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbTHUMoq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 08:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbTHUMop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 08:44:45 -0400
Received: from chaos.analogic.com ([204.178.40.224]:40576 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262661AbTHUMon
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 08:44:43 -0400
Date: Thu, 21 Aug 2003 08:46:08 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Bill J.Xu" <xujz@neusoft.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: "ctrl+c" disabled!
In-Reply-To: <036601c367e0$01adabc0$2a01010a@avwindows>
Message-ID: <Pine.LNX.4.53.0308210842100.2668@chaos>
References: <036601c367e0$01adabc0$2a01010a@avwindows>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Aug 2003, Bill J.Xu wrote:

> hello everyone,
>
> when I connect linux through serial port,and run a program such as "ping xxx.xxx.xxx.xxx",then I can not stop it by using "ctrl+c".and the only way is to telnet it,and kill that progress
>
> why?
>
> thanks
>
> Bill J.Xu
> -
How do you 'connect' through the serial port? You need to use a
serial `getty` that properly sets up the terminal. The 'mini-getty'
used on recent distributions doesn't bother.
Also, if you are not using a real terminal, you need to use a terminal
program that actually sends a ^C.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


