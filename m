Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265362AbUAAKMv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 05:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265366AbUAAKMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 05:12:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:39660 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265362AbUAAKMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 05:12:50 -0500
Date: Thu, 1 Jan 2004 02:12:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Neale Banks <neale@lowendale.com.au>
Cc: paul@clubi.ie, linux-kernel@vger.kernel.org
Subject: Re: chmod of active swap file blocks
Message-Id: <20040101021241.31830e30.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.05.10401011905310.31562-100000@marina.lowendale.com.au>
References: <Pine.LNX.4.56.0312291719160.16956@fogarty.jakma.org>
	<Pine.LNX.4.05.10401011905310.31562-100000@marina.lowendale.com.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neale Banks <neale@lowendale.com.au> wrote:
>
> How much of the original problem goes away if swapon(8) were to refuse to
>  activate a file/device which has ownership/mode which it doesn't like?

I think swapon(8) should at least warn when the swapfile has inappropriate
permissions.  It's an obvious and outright security hole.
