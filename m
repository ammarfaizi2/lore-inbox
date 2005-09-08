Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965066AbVIHWmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbVIHWmO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 18:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965061AbVIHWmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 18:42:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64977 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965059AbVIHWmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 18:42:13 -0400
Date: Thu, 8 Sep 2005 15:41:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tommy Christensen <tommy.christensen@tpack.net>
Cc: Bogdan.Costescu@iwr.uni-heidelberg.de, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] 3c59x: read current link status from phy
Message-Id: <20050908154114.69307f92.akpm@osdl.org>
In-Reply-To: <4320BD96.3060307@tpack.net>
References: <200509080125.j881PcL9015847@hera.kernel.org>
	<431F9899.4060602@pobox.com>
	<Pine.LNX.4.63.0509081351160.21354@dingo.iwr.uni-heidelberg.de>
	<1126184700.4805.32.camel@tsc-6.cph.tpack.net>
	<Pine.LNX.4.63.0509081521140.21354@dingo.iwr.uni-heidelberg.de>
	<1126190554.4805.68.camel@tsc-6.cph.tpack.net>
	<Pine.LNX.4.63.0509081713500.22954@dingo.iwr.uni-heidelberg.de>
	<4320BD96.3060307@tpack.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tommy Christensen <tommy.christensen@tpack.net> wrote:
>
> In order to spare some I/O operations, be more intelligent about
>  when to read from the PHY.

Seems sane.

Should we also decrease the polling interval?  Perhaps only when the cable
is unplugged?
