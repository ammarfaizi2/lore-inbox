Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129698AbRBTMa3>; Tue, 20 Feb 2001 07:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129549AbRBTMaT>; Tue, 20 Feb 2001 07:30:19 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24072 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129129AbRBTMaK>; Tue, 20 Feb 2001 07:30:10 -0500
Subject: Re: Newbie ask for help: cramfs port to isofs
To: ankry@pg.gda.pl (Andrzej Krzysztofowicz)
Date: Tue, 20 Feb 2001 12:30:00 +0000 (GMT)
Cc: zw@debian.org (zhaoway), linux-kernel@vger.kernel.org
In-Reply-To: <200102200935.KAA29865@sunrise.pg.gda.pl> from "Andrzej Krzysztofowicz" at Feb 20, 2001 10:35:20 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14VBvg-0006WJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  	struct buffer_head *bh = NULL;
> > -	int len;
> > -	int map;
> > +	int len = 0;
> 
> This will be the most probably rejected.
> Zero initializers are intentionally removed from the code to decrease
> the kernel image size.

Why. Its not static.

