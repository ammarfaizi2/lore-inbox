Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275012AbRKOKVL>; Thu, 15 Nov 2001 05:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280813AbRKOKVB>; Thu, 15 Nov 2001 05:21:01 -0500
Received: from pizda.ninka.net ([216.101.162.242]:13966 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280809AbRKOKUw>;
	Thu, 15 Nov 2001 05:20:52 -0500
Date: Thu, 15 Nov 2001 02:19:16 -0800 (PST)
Message-Id: <20011115.021916.45712781.davem@redhat.com>
To: anton@samba.org
Cc: groudier@free.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] small sym-2 fix
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011115153654.E22552@krispykreme>
In-Reply-To: <20011115153654.E22552@krispykreme>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Anton Blanchard <anton@samba.org>
   Date: Thu, 15 Nov 2001 15:36:54 +1100
   
   I tested the sym-2 driver on ppc64 and found that hcb_p can be > 1 page
   but __sym_malloc fails for allocations over 1 page. This means we
   die in sym_attach.

Are you using 4K pages on ppc64? :-(

Franks a lot,
David S. Miller
davem@redhat.com
