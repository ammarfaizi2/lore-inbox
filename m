Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbULQThc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbULQThc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 14:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbULQTgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 14:36:10 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:47263
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262129AbULQTfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 14:35:34 -0500
Date: Fri, 17 Dec 2004 11:30:06 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Tomas Carnecky <tom@dbservice.com>
Cc: jmorris@redhat.com, kaber@trash.net, bryan@coverity.com,
       netdev@oss.sgi.com, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Coverity] Untrusted user data in kernel
Message-Id: <20041217113006.3cbae2ba.davem@davemloft.net>
In-Reply-To: <41C334DF.107@dbservice.com>
References: <Xine.LNX.4.44.0412170144410.12579-100000@thoron.boston.redhat.com>
	<41C2DCBC.1080302@dbservice.com>
	<20041217111634.740d4d46.davem@davemloft.net>
	<41C334DF.107@dbservice.com>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2004 20:34:55 +0100
Tomas Carnecky <tom@dbservice.com> wrote:

>  > It is already checked in do_ip6t_set_ctl(). Otherwise anyone could
>  > replace iptables rules :)
> For me it seems that only CAP_NET_ADMIN is checked and not the data.

If that's the case then I agree with you Tomas.
