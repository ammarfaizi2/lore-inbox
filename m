Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287674AbRLaWw0>; Mon, 31 Dec 2001 17:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287675AbRLaWwQ>; Mon, 31 Dec 2001 17:52:16 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:6918 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S287674AbRLaWwO>;
	Mon, 31 Dec 2001 17:52:14 -0500
Message-Id: <200112312251.fBVMpNws032221@sleipnir.valparaiso.cl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system 
In-Reply-To: Your message of "Fri, 28 Dec 2001 18:24:02 -0000."
             <E16K1fn-0001Ky-00@the-village.bc.nu> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Mon, 31 Dec 2001 19:51:23 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> said:
> Something like:
> 
> 	find $TOPDIR -name "*.cf" -exec cat {} \; > Configure.help 

Make that:

     cat `find $TOPDIR -name "*.cf"` > Configure.help #;-)
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
