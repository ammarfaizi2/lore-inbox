Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266052AbUFWCAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266052AbUFWCAX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 22:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266058AbUFWCAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 22:00:23 -0400
Received: from mx2.redhat.com ([66.187.237.31]:20379 "EHLO mx2.redhat.com")
	by vger.kernel.org with ESMTP id S266052AbUFWCAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 22:00:19 -0400
Date: Tue, 22 Jun 2004 18:58:47 -0700
From: "David S. Miller" <davem@redhat.com>
To: Anton Blanchard <anton@samba.org>
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org, rddunlap@osdl.org,
       akpm@osdl.org
Subject: Re: [profile]: [0/23] mmap() support for /proc/profile
Message-Id: <20040622185847.39c8384d.davem@redhat.com>
In-Reply-To: <20040622231646.GA17387@krispykreme>
References: <0406220816.1a3aYaLbLbXaKbKb1aWa4a1a3a2a3aIb2a0aZaWaHb4aXaXaZa1aKbZaWa5aHb3a15250@holomorphy.com>
	<20040622231646.GA17387@krispykreme>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2004 09:16:46 +1000
Anton Blanchard <anton@samba.org> wrote:

> Considering how rarely timer based profiling is used, perhaps RCU
> or even just a profiling_enabled sysctl flag would help here.

RCU seems very appropriate for this.
