Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281021AbRKOT17>; Thu, 15 Nov 2001 14:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281016AbRKOT1q>; Thu, 15 Nov 2001 14:27:46 -0500
Received: from [216.101.162.242] ([216.101.162.242]:47506 "EHLO
	pizda.ninka.net") by vger.kernel.org with ESMTP id <S281018AbRKOT04>;
	Thu, 15 Nov 2001 14:26:56 -0500
Date: Thu, 15 Nov 2001 11:26:06 -0800 (PST)
Message-Id: <20011115.112606.62677098.davem@redhat.com>
To: groudier@free.fr
Cc: anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] small sym-2 fix
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011115172204.B1589-100000@gerard>
In-Reply-To: <20011115153654.E22552@krispykreme>
	<20011115172204.B1589-100000@gerard>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=big5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by leeloo.zip.com.au id GAA24074

   From: Gérard Roudier <groudier@free.fr>
   Date: Thu, 15 Nov 2001 17:27:38 +0100 (CET)
   
   The driver should not need more than 4096 bytes for a single allocation.

If platform is 64-bit and PAGE_SIZE < 8K, yes it will.
And ppc64 fits this criteria.
ý:.žË›±Êâmçë¢kaŠÉb²ßìzwm…ébïîžË›±Êâmébžìÿ‘êçz_âžØ^n‡r¡ö¦zËëh™¨è­Ú&£ûàz¿äz¹Þ—ú+€Ê+zf£¢·hšˆ§~†­†Ûiÿÿïêÿ‘êçz_è®æj:+v‰¨þ)ß£ømšSåy«­æ¶…­†ÛiÿÿðÃí»è®å’i
