Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269834AbUH0B2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269834AbUH0B2j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 21:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269931AbUH0BXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 21:23:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11200 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269930AbUH0BSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 21:18:38 -0400
Date: Thu, 26 Aug 2004 18:18:20 -0700
From: "David S. Miller" <davem@redhat.com>
To: shane@hathawaymix.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] e1000 rx buffer allocation
Message-Id: <20040826181820.34b047ff.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.60.0408261727170.9545@orangutan.jungle>
References: <Pine.LNX.4.60.0408261727170.9545@orangutan.jungle>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004 17:35:38 -0600 (MDT)
shane@hathawaymix.org wrote:

> Independently of my patch, I'm a little concerned about what will happen 
> if the driver runs out of rx buffers.  Ideally, it will just drop packets, 
> but I wonder if the code will panic instead.
