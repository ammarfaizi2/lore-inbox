Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbUK3D7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbUK3D7T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 22:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbUK3D7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 22:59:19 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:12216
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261967AbUK3D7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 22:59:17 -0500
Date: Mon, 29 Nov 2004 19:56:44 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Patrick Caulfield <patrick@tykepenguin.com>
Cc: linux-kernel@vger.kernel.org, linux-decnet-user@lists.sourceforge.net
Subject: Re: [PATCH 2.6] DECnet typo in accept causes oops
Message-Id: <20041129195644.4819d92b.davem@davemloft.net>
In-Reply-To: <20041129160522.GP16269@tykepenguin.com>
References: <20041129160522.GP16269@tykepenguin.com>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2004 16:05:22 +0000
Patrick Caulfield <patrick@tykepenguin.com> wrote:

> This patch fixes typo which can cause a rare oops in accept. dn_accept returns
> a pointer instead of an error if dn_wait_for_connect() is interrupted.
> This confuses sys_accept which calls dn_getname with a incomplete struct socket,
> this then oopses.

Applied, thanks Patrick.
