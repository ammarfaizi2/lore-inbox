Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbVBIVS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVBIVS3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 16:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbVBIVS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 16:18:29 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:15066
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261931AbVBIVRt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 16:17:49 -0500
Date: Wed, 9 Feb 2005 13:17:10 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Einar =?ISO-8859-1?Q?L=FCck?= <lkml@einar-lueck.de>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH 2/2] ipv4 routing: multipath with cache support,
 2.6.10-rc3
Message-Id: <20050209131710.00315044.davem@davemloft.net>
In-Reply-To: <420A75BF.1080106@einar-lueck.de>
References: <41C6B54F.2020604@einar-lueck.de>
	<20050202172333.4d0ad5f0.davem@davemloft.net>
	<420A1011.1030602@einar-lueck.de>
	<20050209120157.18dc75c1.davem@davemloft.net>
	<420A715D.7050106@einar-lueck.de>
	<20050209123004.2d65e1cf.davem@davemloft.net>
	<420A75BF.1080106@einar-lueck.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Feb 2005 21:42:39 +0100
Einar Lück <lkml@einar-lueck.de> wrote:

> We considered the routing case: in the routing case ip_route_input is called. 
> In this case we just select the first route in the cache which is always the same 
> (we ensure that). Consequently, the routing behaviour is not changed in this case and 
> remains in the way you like it. 

Indeed.  You're right.  Let me re-review your second patch with
this new understanding in mind :-)
