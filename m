Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266125AbSKGAnb>; Wed, 6 Nov 2002 19:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266245AbSKGAnb>; Wed, 6 Nov 2002 19:43:31 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:49553 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S266125AbSKGAna>; Wed, 6 Nov 2002 19:43:30 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 6 Nov 2002 17:00:02 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] epoll bits 0.30 ...
In-Reply-To: <Pine.LNX.4.44.0211061641180.953-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.44.0211061659220.953-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2002, Davide Libenzi wrote:

> Rusty, the hash is not under pressure over there. The only time seeks is
> performed is at file removal ( from the set ) and eventually at file
> modify. There's a direct link between the wait queue and its item during
> the high frequency event delivery, so need seek is performed.

s/so need seek is performed/so no seek is performed/



- Davide


