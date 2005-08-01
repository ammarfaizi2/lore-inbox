Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262413AbVHAHD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbVHAHD5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 03:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbVHAHDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 03:03:51 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:37271
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262408AbVHAHDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 03:03:15 -0400
Date: Mon, 01 Aug 2005 00:03:12 -0700 (PDT)
Message-Id: <20050801.000312.82053332.davem@davemloft.net>
To: alexandre.buisse@ens-lyon.fr
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc4-mm1
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <42EDB89D.30209@ens-lyon.fr>
References: <20050731020552.72623ad4.akpm@osdl.org>
	<42EDB89D.30209@ens-lyon.fr>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>
Date: Mon, 01 Aug 2005 07:52:29 +0200

> I have this when I enable nfnetlink as a module :
> 
> net/built-in.o: In function `ip_ct_port_tuple_to_nfattr':
> : undefined reference to `__nfa_fill'

This got fixed in -mm2 and later methinks.
