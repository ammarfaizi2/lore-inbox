Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAIQQB>; Tue, 9 Jan 2001 11:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129884AbRAIQPv>; Tue, 9 Jan 2001 11:15:51 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:34316 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129324AbRAIQPm>; Tue, 9 Jan 2001 11:15:42 -0500
Subject: Re: [PATCH] dn_keyb.c: restore_flags on failure
To: acme@conectiva.com.br (Arnaldo Carvalho de Melo)
Date: Tue, 9 Jan 2001 16:17:30 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010109113837.P21057@conectiva.com.br> from "Arnaldo Carvalho de Melo" at Jan 09, 2001 11:38:37 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14G1Sm-0006t5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  		keyb_cmds[keyb_cmd_write++]=*(cmd++);
>  		if(keyb_cmd_write==keyb_cmd_read)
> -			return;
># +			goto out;

Hans Grobler beat you to this one
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
