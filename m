Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265694AbSKALAA>; Fri, 1 Nov 2002 06:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265693AbSKALAA>; Fri, 1 Nov 2002 06:00:00 -0500
Received: from pizda.ninka.net ([216.101.162.242]:36811 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265686AbSKAK77>;
	Fri, 1 Nov 2002 05:59:59 -0500
Date: Fri, 01 Nov 2002 02:56:15 -0800 (PST)
Message-Id: <20021101.025615.57289488.davem@redhat.com>
To: adam@yggdrasil.com
Cc: netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Patch?: linux-2.5.45/net - __secpath_destroy made net depend
 on ipv4
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021101034500.A484@baldur.yggdrasil.com>
References: <20021101034500.A484@baldur.yggdrasil.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Adam J. Richter" <adam@yggdrasil.com>
   Date: Fri, 1 Nov 2002 03:45:00 -0800

   	In linux-2.5.45, the core networking code calls
   __secpath_destroy via the static inline routine secpath_put in
   include/net/xfrm.h.

Yes, we are fully aware of this.  It will be fixed in due time,
please use CONFIG_INET=y kernels for the time being.

