Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263163AbUJ1X5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbUJ1X5v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 19:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263105AbUJ1XpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 19:45:16 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:52111
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S263110AbUJ1Xii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:38:38 -0400
Date: Thu, 28 Oct 2004 16:26:43 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: acme@conectiva.com.br, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] appletalk: remove an unused function
Message-Id: <20041028162643.2ee7e30e.davem@davemloft.net>
In-Reply-To: <20041028221046.GI3207@stusta.de>
References: <20041028221046.GI3207@stusta.de>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2004 00:10:46 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> - -static inline void atalk_insert_socket(struct sock *sk)
> - -{
> - -	write_lock_bh(&atalk_sockets_lock);
> - -	__atalk_insert_socket(sk);
> - -	write_unlock_bh(&atalk_sockets_lock);
> - -}
> - -

This is a patch of a patch, I doubt it will apply cleanly ;-)
