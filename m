Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129703AbRABISJ>; Tue, 2 Jan 2001 03:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130164AbRABIR7>; Tue, 2 Jan 2001 03:17:59 -0500
Received: from pizda.ninka.net ([216.101.162.242]:64898 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129703AbRABIRq>;
	Tue, 2 Jan 2001 03:17:46 -0500
Date: Mon, 1 Jan 2001 23:29:45 -0800
Message-Id: <200101020729.XAA14188@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: tommy@teatime.com.tw
CC: linux-kernel@vger.kernel.org
In-Reply-To: <3A515199.5388E685@teatime.com.tw> (message from Tommy Wu on Tue,
	02 Jan 2001 11:57:13 +0800)
Subject: Re: Sparc64 compile error for 2.4.0-prerelease
In-Reply-To: <3A513089.9AF6EB6A@teatime.com.tw> <200101020252.SAA01602@pizda.ninka.net> <3A515199.5388E685@teatime.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Tue, 02 Jan 2001 11:57:13 +0800
   From: Tommy Wu <tommy@teatime.com.tw>

     This patch still has problem for define 'HZ' in
     'asm-sparc64/delay.h'.  It defined in linux/param.h.

I've been doing only SMP builds lately which is why I didn't
catch this, thanks a lot.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
