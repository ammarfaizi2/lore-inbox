Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbUARMX0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 07:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbUARMX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 07:23:26 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:9487 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261567AbUARMXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 07:23:01 -0500
Date: Sun, 18 Jan 2004 13:25:28 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Sam Ravnborg <sam@ravnborg.org>, Witold Krecicki <adasi@kernel.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix/improve modular IDE (Re: [PATCH] modular IDE for 2.6.1 ugly but working fix)
Message-ID: <20040118122528.GA2555@mars.ravnborg.org>
Mail-Followup-To: Arkadiusz Miskiewicz <arekm@pld-linux.org>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Sam Ravnborg <sam@ravnborg.org>, Witold Krecicki <adasi@kernel.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200401171313.52545.adasi@kernel.pl> <20040117153830.GA3009@mars.ravnborg.org> <200401171702.35705.bzolnier@elka.pw.edu.pl> <200401181252.49861.arekm@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401181252.49861.arekm@pld-linux.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 18, 2004 at 12:52:49PM +0100, Arkadiusz Miskiewicz wrote:
> Dnia sob 17. stycznia 2004 17:02, Bartlomiej Zolnierkiewicz napisa?:
> > On Saturday 17 of January 2004 16:38, Sam Ravnborg wrote:
> > > > +ide-core-objs += ide.o ide-default.o ide-io.o ide-iops.o ide-lib.o \
> > > > +	ide-probe.o ide-taskfile.o
> > >
> > > It would be more consistent to use "ide-core-y" since this is
> > > what the following lines are expanded to.
> > >
> > > > +
> > > > +ide-core-$(CONFIG_BLK_DEV_CMD640)	+= pci/cmd640.o
> > >
> > > Like this line.
> >
> > Yep, thanks!
> Could you send updated patch so we could test it?
The change I requested is cosmetic only. It may have a small impact on
link-order, but that would not make a difference in this case.

	Sam
