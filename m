Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266352AbUIABia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266352AbUIABia (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 21:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266324AbUIABia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 21:38:30 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:16777
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S266352AbUIABiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 21:38:24 -0400
Date: Tue, 31 Aug 2004 18:21:09 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: linux-kernel@vger.kernel.org, adaplas@pol.net
Subject: Re: 2.6.9-rc1: scrolling with tdfxfb 5 times slower
Message-Id: <20040831182109.3a67dd8f.davem@davemloft.net>
In-Reply-To: <200408312133.40039.ornati@fastwebnet.it>
References: <200408312133.40039.ornati@fastwebnet.it>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2004 21:33:40 +0200
Paolo Ornati <ornati@fastwebnet.it> wrote:

> The recent changes in frame buffer code seems to affect performance of 
> scrolling on my system:
 ...
> CONFIG_FB=y
> CONFIG_FB_3DFX=y
> # CONFIG_FB_3DFX_ACCEL is not set

Maybe try turning on 3DFX_ACCEL?
