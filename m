Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161151AbWJDOwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161151AbWJDOwh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 10:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161153AbWJDOwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 10:52:36 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:6067 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161151AbWJDOwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 10:52:36 -0400
Subject: Re: [v4l-dvb-maintainer] DVB Kconfig warning in latest kernel
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       v4l-dvb-maintainer@linuxtv.org
In-Reply-To: <45235137.4040604@garzik.org>
References: <45235137.4040604@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 04 Oct 2006 11:52:04 -0300
Message-Id: <1159973524.12965.29.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

Em Qua, 2006-10-04 às 02:14 -0400, Jeff Garzik escreveu:
> When doing 'make allyesconfig && make -sj4' on x86_64:
> 
> drivers/media/dvb/dvb-usb/Kconfig:72:warning: 'select' used by config 
> symbol 'DVB_USB_DIB0700' refer to undefined symbol 'DVB_DIB7000M'

The fix is already at my -git tree:
http://www.kernel.org/git/?p=linux/kernel/git/mchehab/v4l-dvb.git;a=commitdiff;h=39666962a3c598f221bc99e835d9d6046a700d85

It is due to the decision of postponing DiB7000m support to 2.6.20.

Cheers, 
Mauro.

