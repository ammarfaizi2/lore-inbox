Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265108AbUGTCWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265108AbUGTCWX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 22:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265141AbUGTCWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 22:22:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21451 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265108AbUGTCWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 22:22:22 -0400
Date: Mon, 19 Jul 2004 19:18:50 -0700
From: "David S. Miller" <davem@redhat.com>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re[3]: tcp_window_scaling degrades performance
Message-Id: <20040719191850.75256ebe.davem@redhat.com>
In-Reply-To: <1408328554.20040716160157@dns.toxicfilms.tv>
References: <2igbK-82L-13@gated-at.bofh.it>
	<m3zn615exj.fsf@averell.firstfloor.org>
	<505216170.20040716122132@dns.toxicfilms.tv>
	<1408328554.20040716160157@dns.toxicfilms.tv>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2004 16:01:57 +0200
Maciej Soltysiak <solt@dns.toxicfilms.tv> wrote:

> I seem to have isolated the changeset that causes my machines to have
> very slow throughput, even as low as 2kB/s when tcp_window_scaling is
> enabled.

The change is valid, firewalls are just corrupting the connection
when window scaling is in use which is a valid RFC standard
TCP feature.

Please, get the firewall fixed.
