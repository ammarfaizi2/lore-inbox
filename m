Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262687AbVGMLdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbVGMLdU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 07:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbVGMLdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 07:33:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:13185 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262687AbVGMLdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 07:33:18 -0400
Subject: Re: system.map
From: Arjan van de Ven <arjan@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: vacant2005@o2.pl, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0507131302550.14635@yvahk01.tjqt.qr>
References: <200507121834.50084.vacant2005@o2.pl>
	 <Pine.LNX.4.61.0507131220360.14635@yvahk01.tjqt.qr>
	 <1121252168.3959.13.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0507131302550.14635@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 13:33:14 +0200
Message-Id: <1121254395.3959.15.camel@laptopd505.fenrus.org>
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

On Wed, 2005-07-13 at 13:04 +0200, Jan Engelhardt wrote:
> >> >Jul 11 12:18:48 localhost kernel: Inspecting /boot/System.map
> >> >Jul 11 12:18:48 localhost kernel: Loaded 28063 symbols from /boot/System.map.
> >> >Jul 11 12:18:48 localhost kernel: Symbols match kernel version 2.6.12.
> >> >Jul 11 12:18:48 localhost kernel: No module symbols loaded - kernel modules 
> >> >notenabled.
> >
> >so whatever is spewing that is something else, but not the kernel.
> 
> These four messages are the first four ones that appear after the boot loader 
> set EIP to the kernel entry point. The first four printks, if you want so. And 
> apparently, the first four appearing in dmesg, obviously.

do they actually appear in dmesg?
> 
> Maybe some more info helps (from /var/log/boot.msg, a copy of dmesg):

or... is syslog itself printing this into the log at startup?
> 
> 	Inspecting /boot/System.map-2.6.13-TP1

