Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTFGS0y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 14:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263322AbTFGS0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 14:26:54 -0400
Received: from zero.aec.at ([193.170.194.10]:57100 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263319AbTFGS0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 14:26:53 -0400
Date: Sat, 7 Jun 2003 20:40:18 +0200
From: Andi Kleen <ak@muc.de>
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@wide.ad.jp>
Cc: ak@muc.de, linux-kernel@vger.kernel.org, akpm@digeo.com, vojtech@suse.cz
Subject: Re: [PATCH] Making keyboard/mouse drivers dependent on CONFIG_EMBEDDED
Message-ID: <20030607184018.GA3473@averell>
References: <20030607063424.GA12616@averell> <20030607.154958.108408804.yoshfuji@wide.ad.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030607.154958.108408804.yoshfuji@wide.ad.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 07, 2003 at 03:49:58PM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@ wrote:
> Why isn't it enough to change default to "y"?

Because that won't override make oldconfig

> Not showing the config is not good.
> I want to disable it while using standard (not embeded) PC.

You can still. That is what CONFIG_EMBEDDED is for.

-Andi
