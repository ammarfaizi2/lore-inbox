Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265591AbTGXNTw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 09:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265764AbTGXNTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 09:19:52 -0400
Received: from chaos.analogic.com ([204.178.40.224]:35970 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265591AbTGXNTu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 09:19:50 -0400
Date: Thu, 24 Jul 2003 09:36:38 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: how to PAE enable kernel?
In-Reply-To: <200307241233.h6OCX8UF010106@wildsau.idv.uni.linz.at>
Message-ID: <Pine.LNX.4.53.0307240933050.20604@chaos>
References: <200307241233.h6OCX8UF010106@wildsau.idv.uni.linz.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jul 2003, H.Rosmanith (Kernel Mailing List) wrote:

>
> hi,
>
> we have a system with 4G, however, only approx 1G will be used.
> dmesg issues the hint "use a PAE enabled kernel". silly question,
> but how do I PAE enable a kernel? I have found a lot of messages
> about PAE enabled kernels on the net, but not *how* to enable this
> feature.
>
> any hints please?
>
> thanks in advance,
> herbert

Well you can read ../linux-n.n.n/Documentation/Configure.help to
get a broad outline of the features available. Then delete the
CONFIG_NOHIMEM stuff in ../linux-n.n.n/.config and execute
`make oldconfig`, answering the questions you should now
understand from your previous research.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

