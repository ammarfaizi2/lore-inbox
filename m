Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbSKRQZT>; Mon, 18 Nov 2002 11:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262875AbSKRQZT>; Mon, 18 Nov 2002 11:25:19 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:38277 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S262871AbSKRQZT>; Mon, 18 Nov 2002 11:25:19 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 18 Nov 2002 08:32:43 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jakub Jelinek <jakub@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [rfc] epoll interface change and glibc bits ...
In-Reply-To: <20021118111840.B27455@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0211180823580.979-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Jakub Jelinek wrote:

> That is as bad as unsigned long - it is different between 32-bit and 64-bit
> ABIs.

Yeah, you right. I did thin about 32bit and 64bit as two diffferent
kernel-glibc environment, I did not think about 32-64 ABI compatibility.
Ouch, adding a 64bit object will double the size of the event structure :(



- Davide





