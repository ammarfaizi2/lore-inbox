Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311692AbSCaG1o>; Sun, 31 Mar 2002 01:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311860AbSCaG1e>; Sun, 31 Mar 2002 01:27:34 -0500
Received: from pizda.ninka.net ([216.101.162.242]:17355 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S311692AbSCaG10>;
	Sun, 31 Mar 2002 01:27:26 -0500
Date: Sat, 30 Mar 2002 22:21:59 -0800 (PST)
Message-Id: <20020330.222159.48199024.davem@redhat.com>
To: pierre.rousselet@wanadoo.fr
Cc: tim@birdsnest.maths.tcd.ie, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.7
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3CA6819F.3090007@wanadoo.fr>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
   Date: Sun, 31 Mar 2002 05:25:19 +0200

   I've noticed 2.5.7 fails to build without tcp/ip enabled :
   sock.c:559: `TCP_LISTEN' undeclared
   sock.c:1192: `TCP_CLOSE' undeclared

Just add an include of linux/tcp.h to net/core/sock.c, that
should clear it up.

I'll fix this in my sources.
