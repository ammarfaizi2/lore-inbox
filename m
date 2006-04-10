Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWDJXnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWDJXnq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 19:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWDJXnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 19:43:46 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:36314
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932198AbWDJXnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 19:43:46 -0400
Date: Mon, 10 Apr 2006 16:43:16 -0700 (PDT)
Message-Id: <20060410.164316.93690683.davem@davemloft.net>
To: snakebyte@gmx.de
Cc: linux-kernel@vger.kernel.org, acme@conectiva.com.br
Subject: Re: [Patch] leak in net/dccp/ipv4.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1144706846.31667.1.camel@alice>
References: <1144706846.31667.1.camel@alice>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Sesterhenn <snakebyte@gmx.de>
Date: Tue, 11 Apr 2006 00:07:26 +0200

> we dont free req if we cant parse the options.
> This fixes coverity bug id #1046
> 
> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

Looks good.

Applied, thanks Eric.
