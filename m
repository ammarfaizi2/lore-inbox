Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293746AbSCKOIJ>; Mon, 11 Mar 2002 09:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310114AbSCKOHy>; Mon, 11 Mar 2002 09:07:54 -0500
Received: from pizda.ninka.net ([216.101.162.242]:8895 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S310112AbSCKOHJ>;
	Mon, 11 Mar 2002 09:07:09 -0500
Date: Mon, 11 Mar 2002 06:03:24 -0800 (PST)
Message-Id: <20020311.060324.69703263.davem@redhat.com>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
Subject: Re: [PATCH] KERN_INFO 2.4.19-pre2 IP/TCP hash table size printks
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200203111359.g2BDx1q05409@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200203111359.g2BDx1q05409@Port.imtp.ilyichevsk.odessa.ua>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
   Date: Mon, 11 Mar 2002 15:58:15 -0200

   Primary purpose of this patch is to make KERN_WARNING and
   KERN_INFO log levels closer to their original meaning.
   Today they are quite far from what was intended.
   Just look what kernel writes at the WARNING level
   each time you boot your box!

Maybe it is even better idea to change default kernel printk
logging level which is used when no KERN_* is specified, eh?
