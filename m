Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281843AbRLCIv4>; Mon, 3 Dec 2001 03:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281874AbRLCIsv>; Mon, 3 Dec 2001 03:48:51 -0500
Received: from pizda.ninka.net ([216.101.162.242]:63895 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S284476AbRLCAJi>;
	Sun, 2 Dec 2001 19:09:38 -0500
Date: Sun, 02 Dec 2001 16:09:31 -0800 (PST)
Message-Id: <20011202.160931.43504367.davem@redhat.com>
To: hvr@kernel.org
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] inet_ecn.h [2.4.16/2.5.0]
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1007295809.1531.4.camel@janus.txd.hvrlab.org>
In-Reply-To: <1007295809.1531.4.camel@janus.txd.hvrlab.org>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Herbert Valerio Riedel <hvr@kernel.org>
   Date: 02 Dec 2001 13:23:29 +0100

   ...the following allows to build a kernel without CONFIG_INET...

That's not the correct fix, the correct one has been sent
to Marcelo.  The net/core/*.c files are a little over agressive
in including TCP/IP headers when they shouldn't.
