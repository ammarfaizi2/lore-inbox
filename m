Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136342AbRAHX7V>; Mon, 8 Jan 2001 18:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136438AbRAHX7L>; Mon, 8 Jan 2001 18:59:11 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:18684 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S136342AbRAHX65>; Mon, 8 Jan 2001 18:58:57 -0500
Date: Mon, 8 Jan 2001 20:11:04 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Bjorn Ekwall <bj0rn@blox.se>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] de620.c: nitpicking
Message-ID: <20010108201103.E17087@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Bjorn Ekwall <bj0rn@blox.se>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn/Alan,

	Yes, I'm a nitpicker ;)

--- linux-2.4.0-ac3/drivers/net/de620.c	Tue Dec 19 11:24:52 2000
+++ linux-2.4.0-ac3.acme/drivers/net/de620.c	Mon Jan  8 20:06:28 2001
@@ -563,7 +563,6 @@
 		printk(KERN_WARNING "%s: No tx-buffer available!\n", dev->name);
 		restore_flags(flags);
 		return 1;
-		break;
 	}
 	de620_write_block(dev, buffer, len);
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
