Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267369AbTAGI6h>; Tue, 7 Jan 2003 03:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267371AbTAGI6h>; Tue, 7 Jan 2003 03:58:37 -0500
Received: from pizda.ninka.net ([216.101.162.242]:4830 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267369AbTAGI6g>;
	Tue, 7 Jan 2003 03:58:36 -0500
Date: Tue, 07 Jan 2003 00:58:52 -0800 (PST)
Message-Id: <20030107.005852.118939588.davem@redhat.com>
To: roland@topspin.com
Cc: ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] increase MAX_ADDR_LEN
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <52lm25ss0s.fsf@topspin.com>
References: <52wumpbpql.fsf@topspin.com>
	<20021204201138.GA29792@averell>
	<52lm25ss0s.fsf@topspin.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roland Dreier <roland@topspin.com>
   Date: 31 Dec 2002 15:11:31 -0800
   
   There is some suspicious-looking use of MAX_ADDR_LEN in
   drivers/net/sungem.c and drivers/s390/net/lcs.c but I did not touch
   those files in this patch.
 ...   
   Please apply this patch or let me know what needs to change for it to
   be applied.

I applied the patch and added a #warning to the powerpc bits of
sungem.c that look suspicious.

Thanks.
