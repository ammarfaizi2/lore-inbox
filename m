Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbUCGGe4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 01:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbUCGGe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 01:34:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44431 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261491AbUCGGe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 01:34:56 -0500
Date: Sat, 6 Mar 2004 22:34:50 -0800
From: "David S. Miller" <davem@redhat.com>
To: Fredrik Tolf <fredrik@dolda2000.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IP_TOS setsockopt filters away MinCost
Message-Id: <20040306223450.1b569ad3.davem@redhat.com>
In-Reply-To: <16458.44160.469394.230025@pc7.dolda2000.com>
References: <16458.44160.469394.230025@pc7.dolda2000.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Mar 2004 06:00:48 +0100
Fredrik Tolf <fredrik@dolda2000.com> wrote:

> This didn't make sense to me. Is there some reason behind this, and
> would someone like to explain it to me in that case? I just spent an
> hour trying to debug my program to find it why it didn't want to set
> minimal cost, while the other three TOS options worked.

Please read the diffserv RFCs for the current meanins of the TOS
bits.
