Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262048AbUL1DPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbUL1DPU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 22:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbUL1DOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 22:14:55 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:26534
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262041AbUL1DNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 22:13:11 -0500
Date: Mon, 27 Dec 2004 19:08:16 -0800
From: "David S. Miller" <davem@davemloft.net>
To: hadi@cyberus.ca
Cc: bunk@stusta.de, alan@redhat.com, kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/netlink/af_netlink.c: possible cleanups
Message-Id: <20041227190816.1d166ba2.davem@davemloft.net>
In-Reply-To: <1103119623.1077.71.camel@jzny.localdomain>
References: <20041215004604.GH23151@stusta.de>
	<1103119623.1077.71.camel@jzny.localdomain>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Dec 2004 09:07:03 -0500
jamal <hadi@cyberus.ca> wrote:

> I think this should be left alone for now; what we need to do is
> deprecate NETLINK_DEV incase someone is still using it.
> Else we could get rid of it totaly including what Adrian is deleting
> below. Any users of NETLINK_DEV? Maybe deleting the feature will get
> someone whining? ;->

While I agree we should probably just kill NETLINK_DEV now
and don't look back, I have applied Adrian's patch for
the time being.
