Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292938AbSCDWTk>; Mon, 4 Mar 2002 17:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292941AbSCDWTV>; Mon, 4 Mar 2002 17:19:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22027 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292938AbSCDWTC>; Mon, 4 Mar 2002 17:19:02 -0500
Subject: Re: compiler bug generates incorrect code in swap_free() (fix included)
To: cel@monkey.org (Chuck Lever)
Date: Mon, 4 Mar 2002 22:34:12 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, cel@netapp.com
In-Reply-To: <Pine.BSO.4.33.0203041415260.2934-100000@naughty.monkey.org> from "Chuck Lever" at Mar 04, 2002 02:15:45 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16i124-0000pS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> executive summary:  older versions of gcc generate bad assembler in
> swap_free(), causing Oopses when the system is pushed into swapping.
> fix suggested for 2.4.19-pre.

There are several reasons Changes got updated. 	

> i run RedHat 7.0 on my laptop and have encountered system instability on

The 7.0 stock non errata gcc 2.96 is somewhat buggy. The updated one is
ok. Changes specifies

gcc 2.95.3

and also

The Red Hat gcc 2.96 compiler subtree can also be used to build this tree.
You should ensure you use gcc-2.96-74 or later. gcc-2.96-54 will not build
the kernel correctly.

Alan

