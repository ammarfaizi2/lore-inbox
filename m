Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265093AbSKJTEC>; Sun, 10 Nov 2002 14:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265092AbSKJTEB>; Sun, 10 Nov 2002 14:04:01 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:4744 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265093AbSKJTEA>; Sun, 10 Nov 2002 14:04:00 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 10 Nov 2002 11:20:49 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC,PATCH] poll cleanups 1/3
In-Reply-To: <3DCE421F.8000802@colorfullife.com>
Message-ID: <Pine.LNX.4.44.0211101120230.7415-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Nov 2002, Manfred Spraul wrote:

> Change 1:
> Davide added a 'queue' variable into the poll_table, to indicate that no
> wait queue operations should happen.
> This is not needed: setting the poll table to NULL achieves the same
> effect, and is used by select/poll to implement syscalls with a 0 timeout.

Fine for me.



- Davide


