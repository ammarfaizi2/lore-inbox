Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262630AbVGMK6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbVGMK6N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 06:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbVGMK6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 06:58:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1474 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262630AbVGMK4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 06:56:23 -0400
Subject: Re: system.map
From: Arjan van de Ven <arjan@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: vacant2005@o2.pl, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0507131220360.14635@yvahk01.tjqt.qr>
References: <200507121834.50084.vacant2005@o2.pl>
	 <Pine.LNX.4.61.0507131220360.14635@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 12:56:08 +0200
Message-Id: <1121252168.3959.13.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-13 at 12:21 +0200, Jan Engelhardt wrote:
> >After compiling new kernel, it doesn`t load System.map file. In kernel 
> >messages I can find:
> >
> >Jul 11 12:18:48 localhost kernel: Inspecting /boot/System.map
> >Jul 11 12:18:48 localhost kernel: Loaded 28063 symbols from /boot/System.map.
> >Jul 11 12:18:48 localhost kernel: Symbols match kernel version 2.6.12.
> >Jul 11 12:18:48 localhost kernel: No module symbols loaded - kernel modules 
> >notenabled.
> 
> I get the same, but somehow, my symbols are loaded. (When it oopses, derefs 
> a NULL pointer, etc. for example.)

the kernel does not read or use system.map.

so whatever is spewing that is something else, but not the kernel.


