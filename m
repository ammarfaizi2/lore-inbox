Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbUBZT5e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 14:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262973AbUBZT5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 14:57:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64395 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261579AbUBZT5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 14:57:13 -0500
Date: Thu, 26 Feb 2004 11:57:09 -0800
From: "David S. Miller" <davem@redhat.com>
To: "Simon Barber" <simon@instant802.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, bdschuym@pandora.be
Subject: Re: [PATCH 2.4.26-pre1] Allow ebtables module to change protocol in
 netif_receive_skb
Message-Id: <20040226115709.4ed1594d.davem@redhat.com>
In-Reply-To: <AC8C1F46CD753F4AAC8F890E35A9EB461C670B@webmail.instant802.com>
References: <AC8C1F46CD753F4AAC8F890E35A9EB461C670B@webmail.instant802.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Feb 2004 14:47:41 -0800
"Simon Barber" <simon@instant802.com> wrote:

> Currently skb->protocol is read before the bridge is called, even though
> it's not used until after. Hence if an ebtables module changes the
> protocol of a frame the wrong protocol is interpreted.

Applied, even though ebtables is not in 2.4.x yet the change is valid.
I've applied your 2.6.x variant too of course.

Thanks Simon.
