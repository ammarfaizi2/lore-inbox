Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129563AbRBVKfj>; Thu, 22 Feb 2001 05:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129975AbRBVKfT>; Thu, 22 Feb 2001 05:35:19 -0500
Received: from pizda.ninka.net ([216.101.162.242]:1920 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129563AbRBVKfK>;
	Thu, 22 Feb 2001 05:35:10 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14996.60084.907766.762944@pizda.ninka.net>
Date: Thu, 22 Feb 2001 02:32:20 -0800 (PST)
To: Andrey Panin <pazke@orbita.don.sitek.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/net/sunhme.c, unbalanced and unchecked ioremap()
In-Reply-To: <20010222121151.A13350@orbita1.ru>
In-Reply-To: <20010222121151.A13350@orbita1.ru>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrey Panin writes:
 > I found that sunhme.c doesn't check ioremap() return value and doesn't
 > call iounmap() on module unload. Attached patch (for 2.4.1-ac20) should fix it, 
 > compiles clearly, but untested (I have no such hardware).

Thanks I've applied this patch.

Later,
David S. Miller
davem@redhat.com
