Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315178AbSHITgQ>; Fri, 9 Aug 2002 15:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315445AbSHITgQ>; Fri, 9 Aug 2002 15:36:16 -0400
Received: from chaos.analogic.com ([204.178.40.224]:392 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315178AbSHITgP>; Fri, 9 Aug 2002 15:36:15 -0400
Date: Fri, 9 Aug 2002 15:43:00 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Imran Badr <imran.badr@cavium.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel memory swap..
In-Reply-To: <09b101c23fce$398781f0$9e10a8c0@IMRANPC>
Message-ID: <Pine.LNX.3.95.1020809154134.6131A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Aug 2002, Imran Badr wrote:

> 
> Hi,
> 
> If I allocate some memory using kmalloc() in the linux device driver and
> will it ever be swapped to hard disk? If yes, then how can I lock the page?
> 
> Thanks,
> Imran.

Nope. It's locked into the kernel and won't go away until you kfree() it.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

