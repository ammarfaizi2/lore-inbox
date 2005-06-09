Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262278AbVFIF6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbVFIF6W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 01:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbVFIF6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 01:58:22 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:41651
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262278AbVFIF6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 01:58:20 -0400
Date: Wed, 08 Jun 2005 22:58:17 -0700 (PDT)
Message-Id: <20050608.225817.112619139.davem@davemloft.net>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6.12-rc6-mm1 OOPS in tcp_push_one()
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200506090423.j594NWts004829@turing-police.cc.vt.edu>
References: <200506090423.j594NWts004829@turing-police.cc.vt.edu>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valdis.Kletnieks@vt.edu
Date: Thu, 09 Jun 2005 00:23:32 -0400

> (On a related note, how did tcp_bic get loaded? I requested all the new
> congestion stuff be built as modules, didn't specifically request any of
> them to actually be loaded....

It's the default algorithm, so when you open the first TCP
socket it tries to load it.
