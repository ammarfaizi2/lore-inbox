Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbUKXCuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbUKXCuQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 21:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbUKXCs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 21:48:27 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:53897
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261701AbUKXCqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 21:46:46 -0500
Date: Tue, 23 Nov 2004 18:46:02 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Patrick McHardy <kaber@trash.net>
Cc: mg@iceni.pl, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: ipsec hang
Message-Id: <20041123184602.48029039.davem@davemloft.net>
In-Reply-To: <41A3E4B4.8080401@trash.net>
References: <200411240134.50314@senat>
	<41A3E4B4.8080401@trash.net>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2004 02:32:36 +0100
Patrick McHardy <kaber@trash.net> wrote:

> This patch should fix it. The patch "Fix policy update bug when increasing
> priority of last policy" broke this, when a policy with lower priority than
> an existing policy is inserted xfrm_policy_insert loops forever.

Good catch Patrick, patch applied.

Thanks.
