Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbWIAQaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWIAQaP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 12:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030195AbWIAQaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 12:30:15 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:18662 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1030186AbWIAQaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 12:30:13 -0400
Date: Fri, 1 Sep 2006 18:29:08 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Arjan van de Ven <arjan@infradead.org>
cc: Peter Lezoch <pledr@t-online.de>, linux-kernel@vger.kernel.org
Subject: Re: Environment that was used for building/testing of kernel 2.6.x.y
In-Reply-To: <1157125042.2863.57.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0609011827060.18261@yvahk01.tjqt.qr>
References: <1GJAsz-0VDsJ60@fwd27.sul.t-online.de> <1157125042.2863.57.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>the compiler version is actually included in the VERMAGIC already ;)
>also if you type "dmesg | head -2" you get to see the full version of
>the compiler that was used.... What more would you want?

This requires that the dmesg buffer has not yet wrapped.


18:28 shanghai:~ > dmesg | head -n1
Linux version 2.6.17.7-jen31-default (jengelh@shanghai) (gcc version 4.1.0 
(SUSE Linux)) #1 Fri Jul 28 13:15:29 CEST 2006

18:28 shanghai:~ > modinfo cdrom
filename:       
/lib/modules/2.6.17.7-jen31-default/kernel/drivers/cdrom/cdrom.ko
license:        GPL
vermagic:       2.6.17.7-jen31-default mod_unload 586 REGPARM gcc-4.1
depends:        
parm:           mrw_format_restart:bool
parm:           check_media_type:bool
parm:           lockdoor:bool
parm:           autoeject:bool
parm:           autoclose:bool
parm:           debug:bool
18:28 shanghai:~ > strings 
/lib/modules/2.6.17.7-jen31-default/kernel/drivers/cdrom/cdrom.ko | grep 
gcc
vermagic=2.6.17.7-jen31-default mod_unload 586 REGPARM gcc-4.1


Jan Engelhardt
-- 
