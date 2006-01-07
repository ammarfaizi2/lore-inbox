Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030585AbWAGVYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030585AbWAGVYH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 16:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752589AbWAGVYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 16:24:07 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:65208
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1752587AbWAGVYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 16:24:06 -0500
Date: Sat, 07 Jan 2006 13:23:51 -0800 (PST)
Message-Id: <20060107.132351.132009164.davem@davemloft.net>
To: bunk@stusta.de
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] net/ipv4/ip_output.c: make ip_fragment()
 static
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060107181533.GO3774@stusta.de>
References: <20060107181533.GO3774@stusta.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Sat, 7 Jan 2006 19:15:33 +0100

> Since there's no longer any external user of ip_fragment() we can make 
> it static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Works for me, applied.

Thanks.
