Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265143AbSKNRVq>; Thu, 14 Nov 2002 12:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265139AbSKNRVq>; Thu, 14 Nov 2002 12:21:46 -0500
Received: from pizda.ninka.net ([216.101.162.242]:56783 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265134AbSKNRVp>;
	Thu, 14 Nov 2002 12:21:45 -0500
Date: Thu, 14 Nov 2002 09:26:46 -0800 (PST)
Message-Id: <20021114.092646.38763468.davem@redhat.com>
To: sk@deeptown.org
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [NET] Possible bug in netif_receive_skb
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <015301c28c00$f6287390$34c096cd@toybox>
References: <015301c28c00$f6287390$34c096cd@toybox>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


->func() must either take or free up the SKB, there must be no
violations of this rule.
