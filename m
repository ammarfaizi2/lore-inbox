Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129710AbQLNBMt>; Wed, 13 Dec 2000 20:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129736AbQLNBMk>; Wed, 13 Dec 2000 20:12:40 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22030 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129710AbQLNBMY>; Wed, 13 Dec 2000 20:12:24 -0500
Subject: Re: insmod problem after modutils upgrading
To: kaos@ocs.com.au (Keith Owens)
Date: Thu, 14 Dec 2000 00:43:31 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <1696.976752129@kao2.melbourne.sgi.com> from "Keith Owens" at Dec 14, 2000 11:02:09 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146MUg-0003Xb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, if it is going to take that long to fix 2.2 ...  modutils 2.3.23

It may do. 2.2.18 took a long time.

> will make this a semi-warning.  modules with invalid MODULE_PARM for
> options that are not used will load, but the module will not support
> persistent data.  If somebody actually tries to use one of the invalid
> options then insmod will fail, it already does this.

That sounds fine. Warning is sensible, not supporting persistent data is
obvious enough and 2.2 doesnt do that yet so it isnt a problem.

Alan


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
