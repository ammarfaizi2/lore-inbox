Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292631AbSCDUV0>; Mon, 4 Mar 2002 15:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292836AbSCDUVO>; Mon, 4 Mar 2002 15:21:14 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:11012 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S292631AbSCDUU7>; Mon, 4 Mar 2002 15:20:59 -0500
Date: Mon, 4 Mar 2002 20:20:51 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: <matthew@sphinx.mythic-beasts.com>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fast Userspace Mutexes III.
In-Reply-To: <Pine.LNX.4.44.0203041208310.1561-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0203042019360.8209-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2002, Davide Libenzi wrote:

[ cc: list trimmage ]

> Or, is the kernel code the slow path or you enter it by default ?

The kernel part is the slow path -- we only enter it
when we have contention and want to sleep.

Matthew.

