Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266061AbUAQP6k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 10:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266063AbUAQP6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 10:58:40 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:36518 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266061AbUAQP6j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 10:58:39 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] fix/improve modular IDE (Re: [PATCH] modular IDE for 2.6.1 ugly but working fix)
Date: Sat, 17 Jan 2004 17:02:35 +0100
User-Agent: KMail/1.5.3
Cc: Witold Krecicki <adasi@kernel.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200401171313.52545.adasi@kernel.pl> <200401171422.06211.bzolnier@elka.pw.edu.pl> <20040117153830.GA3009@mars.ravnborg.org>
In-Reply-To: <20040117153830.GA3009@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401171702.35705.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Saturday 17 of January 2004 16:38, Sam Ravnborg wrote:
> > +ide-core-objs += ide.o ide-default.o ide-io.o ide-iops.o ide-lib.o \
> > +	ide-probe.o ide-taskfile.o
>
> It would be more consistent to use "ide-core-y" since this is
> what the following lines are expanded to.
>
> > +
> > +ide-core-$(CONFIG_BLK_DEV_CMD640)	+= pci/cmd640.o
>
> Like this line.

Yep, thanks!

