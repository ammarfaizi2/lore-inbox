Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318736AbSHLP5y>; Mon, 12 Aug 2002 11:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318741AbSHLP5y>; Mon, 12 Aug 2002 11:57:54 -0400
Received: from chaos.analogic.com ([204.178.40.224]:26762 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318736AbSHLP5x>; Mon, 12 Aug 2002 11:57:53 -0400
Date: Mon, 12 Aug 2002 12:04:05 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: daniel sheltraw <l5gibson@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel to user-space communication
In-Reply-To: <F137zkftciAlUNLFAYp000015b2@hotmail.com>
Message-ID: <Pine.LNX.3.95.1020812120306.16590A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2002, daniel sheltraw wrote:

> Hello Kernel
> 
> Is there a way to comminicate to a user-space program that an
> interrupt has occurred in a kernel module?
> 
> Thanks,
> Daniel Sheltraw

Yes, poll() or select(). Look at some character drivers in the kernel.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

