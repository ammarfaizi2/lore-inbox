Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVFNAGC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVFNAGC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 20:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbVFNAFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 20:05:55 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:25039
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261164AbVFNABE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 20:01:04 -0400
Date: Mon, 13 Jun 2005 17:00:45 -0700 (PDT)
Message-Id: <20050613.170045.74749212.davem@davemloft.net>
To: ak@muc.de
Cc: jesper.juhl@gmail.com, mru@inprovide.com, rommer@active.by,
       bernd@firmix.at, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: udp.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <m1fyvlbyp7.fsf@muc.de>
References: <20050613230422.GA7269@gondor.apana.org.au>
	<20050613.162052.41635836.davem@davemloft.net>
	<m1fyvlbyp7.fsf@muc.de>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@muc.de>
Date: Tue, 14 Jun 2005 01:53:56 +0200

> Still does, as does x86-64, but actually it could be changed now using
> change_page_attr (and then later undoing it). Is it worth it?

A lot of bootup OOPS's have occured in the past and
were never discovered until someone on a non-x86
platform tested the patch.
