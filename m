Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266053AbUAQPg1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 10:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266056AbUAQPg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 10:36:27 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:4103 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S266053AbUAQPg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 10:36:26 -0500
Date: Sat, 17 Jan 2004 16:38:30 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Witold Krecicki <adasi@kernel.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix/improve modular IDE (Re: [PATCH] modular IDE for 2.6.1 ugly but working fix)
Message-ID: <20040117153830.GA3009@mars.ravnborg.org>
Mail-Followup-To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Witold Krecicki <adasi@kernel.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200401171313.52545.adasi@kernel.pl> <200401171422.06211.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401171422.06211.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  
> +ide-core-objs += ide.o ide-default.o ide-io.o ide-iops.o ide-lib.o \
> +	ide-probe.o ide-taskfile.o

It would be more consistent to use "ide-core-y" since this is
what the following lines are expanded to.

> +
> +ide-core-$(CONFIG_BLK_DEV_CMD640)	+= pci/cmd640.o
Like this line.

	Sam
