Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266113AbTGIToL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 15:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266118AbTGIToK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 15:44:10 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:51377 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S266113AbTGIToH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 15:44:07 -0400
Message-Id: <200307091958.h69Jw50k013965@eeyore.valparaiso.cl>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.7x: No vga=0x317? 
In-Reply-To: Your message of "Wed, 09 Jul 2003 00:44:19 +0100."
             <Pine.LNX.4.44.0307090043480.32323-100000@phoenix.infradead.org> 
X-Mailer: MH-E 7.1; nmh 1.0.4; XEmacs 21.4
Date: Wed, 09 Jul 2003 15:58:05 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons <jsimmons@infradead.org> said:
> Horst von Brand <vonbrand@inf.utfsm.cl> said:
> > This is a Toshiba Satellite notebook 1800 (P3 mobile/1100, 256MiB RAM,
> > Trident CyberBlade XPAi1 (rev 82) graphics card; RH 9.
> 
> Are you using the vesafb driver or the Trident one? 

My .config in the relevant section (sans "# mumble foo is not set" lines)
looks like:

#
# Graphics support
#
CONFIG_FB=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_TRIDENT=m

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_MDA_CONSOLE=m
CONFIG_DUMMY_CONSOLE=y

No special setup in initrd above what RH 9 does.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
