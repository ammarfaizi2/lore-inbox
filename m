Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317328AbSHHPHb>; Thu, 8 Aug 2002 11:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317591AbSHHPHb>; Thu, 8 Aug 2002 11:07:31 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1763 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317328AbSHHPHb>;
	Thu, 8 Aug 2002 11:07:31 -0400
Date: Thu, 08 Aug 2002 07:58:16 -0700 (PDT)
Message-Id: <20020808.075816.56749431.davem@redhat.com>
To: laforge@gnumonks.org
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix HIPQUAD macro in kernel.h
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020808133112.E11828@sunbeam.de.gnumonks.org>
References: <20020808133112.E11828@sunbeam.de.gnumonks.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Harald Welte <laforge@gnumonks.org>
   Date: Thu, 8 Aug 2002 13:31:12 +0200

   Below is a fix for the HIPQUAD macro in kernel.h.  The macro is currently
   not endian-aware - it just assumes running on a little-endian machine.
   
This looks fine, I've added it to both my 2.4.x and 2.5.x
networking trees.

Thanks.
