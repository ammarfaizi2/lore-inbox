Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269618AbUJFW6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269618AbUJFW6G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 18:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269531AbUJFWzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 18:55:09 -0400
Received: from chaos.analogic.com ([204.178.40.224]:10118 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S269593AbUJFWwE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 18:52:04 -0400
Date: Wed, 6 Oct 2004 18:51:49 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alan Kilian <kilian@bobodyne.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Driver access ito PCI card memory space question.
In-Reply-To: <200410062020.i96KKPN13520@raceme.attbi.com>
Message-ID: <Pine.LNX.4.61.0410061849390.7214@chaos.analogic.com>
References: <200410062020.i96KKPN13520@raceme.attbi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2004, Alan Kilian wrote:

>
>
>  Folks,
>
>     I'm not sure how to access the memory spaces on my PCI card.
>
>     I do
>
>     From /var/log/messages:
>
> 		SSE: Start of card attachment.
> 		SSE: Found a DeCypher card, interrupting on line 3
> 		SSE: Bar0 From 0xfeaff000 to 0xfeafffff F=0x200 MEMORY space
> 		SSE: Bar1 From 0xfeafc000 to 0xfeafdfff F=0x200 MEMORY space
> 		SSE: Bar2 From 0xfe000000 to 0xfe7fffff F=0x200 MEMORY space
>
>     My driver detects the card, and asks about the memory areas.
>

Please look at a driver module that uses PCI. There are plenty in
the kernel.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.5-1.358-noreg on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

