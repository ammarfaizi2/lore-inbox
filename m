Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUJHSdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUJHSdq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 14:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263962AbUJHSa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 14:30:57 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:37039
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S270078AbUJHSWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 14:22:08 -0400
Date: Fri, 8 Oct 2004 11:20:32 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Update tcp_tso_win_divisor sysctl information in
 ip-sysctl.txt
Message-Id: <20041008112032.769b632e.davem@davemloft.net>
In-Reply-To: <1886784988.20041008141045@dns.toxicfilms.tv>
References: <1886784988.20041008141045@dns.toxicfilms.tv>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Oct 2004 14:10:45 +0200
Maciej Soltysiak <solt2@dns.toxicfilms.tv> wrote:

> I noticed that newly added tcp_tso_win_divisor did not go
> with a description to ip-sysctl.txt
> 
> This patch updates this information.

The implementation isn't cast in stone yet, I still want to play
with including tp->max_window in the clamps somehow and I'll add
the docs after I'm doing experimenting with that.
