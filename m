Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262259AbVBBXyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbVBBXyg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 18:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbVBBXpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 18:45:09 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:48528
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262593AbVBBXlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 18:41:18 -0500
Date: Wed, 2 Feb 2005 15:34:49 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: jmorris@redhat.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       michal@logix.cz
Subject: Re: [PATCH 01/04] Adding cipher mode context information to
 crypto_tfm
Message-Id: <20050202153449.1e92c29a.davem@davemloft.net>
In-Reply-To: <1107386909.19339.9.camel@ghanima>
References: <Xine.LNX.4.44.0502021728140.5000-100000@thoron.boston.redhat.com>
	<1107386909.19339.9.camel@ghanima>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Feb 2005 00:28:29 +0100
Fruhwirth Clemens <clemens@endorphin.org> wrote:

> I suspected unlikely to be a hint for the compiler to do better jump
> prediction and speculations. Remove?

I don't think it hurts, keep it in there.

When the final patch is made with James's requested fixups, I'll stick
this into the 2.6.12 pending tree.

Also, I think there will be objections to that studlyCaps naming you
said your other code has.  Keep garbage like that in the x11 sources,
if you don't mind :-)
