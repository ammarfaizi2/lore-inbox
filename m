Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbVDRTcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbVDRTcA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 15:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbVDRTb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 15:31:59 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:62394
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262178AbVDRTbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 15:31:53 -0400
Date: Mon, 18 Apr 2005 12:26:00 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_Garc=EDa-Hierro?= 
	<lorenzo@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TCP ipv4 source port randomization
Message-Id: <20050418122600.0664f26b.davem@davemloft.net>
In-Reply-To: <1113851051.17341.94.camel@localhost.localdomain>
References: <1113851051.17341.94.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Stephen Hemminger has already added TCP port randomization on
connect() to the 2.6.x tree.  See
net/ipv4/tcp_ipv4.c:tcp_v4_hash_connect(), where randomized port
selection occurs.  And unlike your patch, Stephen did add ipv6
support (via net/ipv6/tcp_ipv6.c:tcp_v6_hash_connect()) for
port randomization as well.

I'd like to ask two things:

1) That you use netdev@oss.sgi.com for networking patches as that
   is where the networking developers listen.
2) That you do some checking to see that the feature you're adding
   is not already present in the tree.

Thanks a lot.
