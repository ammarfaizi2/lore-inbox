Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbVLNGsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbVLNGsX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 01:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbVLNGsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 01:48:23 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:22946
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751179AbVLNGsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 01:48:22 -0500
Date: Tue, 13 Dec 2005 22:47:38 -0800 (PST)
Message-Id: <20051213.224738.130590565.davem@davemloft.net>
To: davej@redhat.com
Cc: linux-kernel@vger.kernel.org, shemminger@osdl.org, jgarzik@pobox.com,
       netdev@vger.kernel.org
Subject: Re: [PATCH] skge: get rid of warning on race
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051214053708.GA10486@redhat.com>
References: <200512130559.jBD5xUjf015319@hera.kernel.org>
	<20051214053708.GA10486@redhat.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>
Date: Wed, 14 Dec 2005 00:37:08 -0500

> drivers/net/skge.ko needs unknown symbol netif_stopped

it's a typo, it should be netif_queue_stopped(). :-/
