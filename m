Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129175AbRBLXRX>; Mon, 12 Feb 2001 18:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129154AbRBLXRM>; Mon, 12 Feb 2001 18:17:12 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2822 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129075AbRBLXQ7>; Mon, 12 Feb 2001 18:16:59 -0500
Subject: Re: LILO and serial speeds over 9600
To: Werner.Almesberger@epfl.ch (Werner Almesberger)
Date: Mon, 12 Feb 2001 23:16:29 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), hpa@transmeta.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010213001123.D17129@almesberger.net> from "Werner Almesberger" at Feb 13, 2001 12:11:23 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SSCt-0008RR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Explain 'controlled buffer overrun'.
> 
> That's probably the ability to send new data even if there's unacked old
> data (e.g. because the receiver can't keep up or because we've had losses).

Well let me see, the typical window on the other end of the connection if
its a normal PC class host will be 32K. I think that should be sufficient.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
