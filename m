Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285099AbSALH7V>; Sat, 12 Jan 2002 02:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285369AbSALH7L>; Sat, 12 Jan 2002 02:59:11 -0500
Received: from pizda.ninka.net ([216.101.162.242]:49792 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S285099AbSALH64>;
	Sat, 12 Jan 2002 02:58:56 -0500
Date: Fri, 11 Jan 2002 23:58:01 -0800 (PST)
Message-Id: <20020111.235801.35505714.davem@redhat.com>
To: "ChristianK."@t-online.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Briging doesn't compile without TCP/IP Networking
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <16P5j6-16m9PEC@fwd03.sul.t-online.com>
In-Reply-To: <16On3u-1zr9mqC@fwd05.sul.t-online.com>
	<20020110.191713.48532251.davem@redhat.com>
	<16P5j6-16m9PEC@fwd03.sul.t-online.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "ChristianK."@t-online.de (Christian Koenig)
   Date: Fri, 11 Jan 2002 18:46:25 +0100

   Check,this one is this better ?

Did you try to compile it? :-)  The net/unix/*.c parts
really do need TCP state definitions, so just changing
net/tcp.h to linux/tcp.h would be the fix in those parts.

I've done this and added it to my tree.
Thanks.
