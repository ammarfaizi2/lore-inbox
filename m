Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbUJZBZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbUJZBZr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 21:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbUJZBUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:20:52 -0400
Received: from zeus.kernel.org ([204.152.189.113]:4051 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261899AbUJZBRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:17:55 -0400
Date: Mon, 25 Oct 2004 16:36:47 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Andrea Arcangeli <andrea@novell.com>
Cc: akpm@osdl.org, marcelo.tosatti@cyclades.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: accept should return ENFILE if it runs out of inodes
Message-Id: <20041025163647.116fd3b1.davem@davemloft.net>
In-Reply-To: <20041021004127.GO24619@dualathlon.random>
References: <20041021004127.GO24619@dualathlon.random>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2004 02:41:27 +0200
Andrea Arcangeli <andrea@novell.com> wrote:

> EMFILE is only for the per-process fds limit, all other cases where
> sock_alloc fails already returns -ENFILE too, must have been a typo.

Fix applied to both 2.4.x and 2.6.x, thanks Andrea.
