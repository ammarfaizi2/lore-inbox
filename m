Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131564AbRDCMHU>; Tue, 3 Apr 2001 08:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131629AbRDCMHL>; Tue, 3 Apr 2001 08:07:11 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5381 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131606AbRDCMHE>; Tue, 3 Apr 2001 08:07:04 -0400
Subject: Re: Larger dev_t
To: ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser)
Date: Tue, 3 Apr 2001 13:06:33 +0100 (BST)
Cc: Andries.Brouwer@cwi.nl, torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        hpa@transmeta.com, linux-kernel@vger.kernel.org, tytso@MIT.EDU
In-Reply-To: <20010403120911.B4561@nightmaster.csn.tu-chemnitz.de> from "Ingo Oeser" at Apr 03, 2001 12:09:11 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kPZz-0007tk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Device numbers have to be uniqe only during one power on -> run ->
> power off cycle. For the rest applications should store device
> names instead anyway. The applications, that don't are buggy by
> defintion.

Device numbers/names have to be constant in order to detect disk layout changes
across boots.

Alan

