Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263603AbUCYUdq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 15:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263609AbUCYUdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 15:33:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:918 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263603AbUCYUdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 15:33:44 -0500
Date: Thu, 25 Mar 2004 12:32:06 -0800
From: "David S. Miller" <davem@redhat.com>
To: Sridhar Samudrala <sri@us.ibm.com>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] Consolidate multiple implementations of jiffies-msecs
 conversions.
Message-Id: <20040325123206.00b2dd1a.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0403251142110.3037@localhost.localdomain>
References: <Pine.LNX.4.58.0403251142110.3037@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2004 12:17:41 -0800 (PST)
Sridhar Samudrala <sri@us.ibm.com> wrote:

> The following patch to 2.6.5-rc2 consolidates 6 different implementations
> of msecs to jiffies and 3 different implementation of jiffies to msecs.
> All of them now use the generic msecs_to_jiffies() and jiffies_to_msecs()
> that are added to include/linux/time.h

This looks fine to me.

Jeff, I'll merge this upstream.

Thanks.
