Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263774AbTKSAq7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 19:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbTKSAq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 19:46:59 -0500
Received: from rth.ninka.net ([216.101.162.244]:44416 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263774AbTKSAq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 19:46:58 -0500
Date: Tue, 18 Nov 2003 16:46:16 -0800
From: "David S. Miller" <davem@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: leif@gci.net, linux-kernel@vger.kernel.org
Subject: Re: error in Sparc64 rwlock.S
Message-Id: <20031118164616.2c6d82b5.davem@redhat.com>
In-Reply-To: <20031118130956.1edd4a24.akpm@osdl.org>
References: <200212112043.gBBKhLE28272@devserv.devel.redhat.com>
	<00de01c3ae17$1ac8bd70$31828ad0@internet.gci.net>
	<20031118130956.1edd4a24.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Nov 2003 13:09:56 -0800
Andrew Morton <akpm@osdl.org> wrote:

> OK, the lockmeter patch adds a write_trylock() implementation to sparc64,
> but now Linus's tree has one anyway.

That's correct, it's needed even in Linus's tree for the sake
of preempt support on SMP.
