Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266240AbUARLxo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 06:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266354AbUARLxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 06:53:44 -0500
Received: from smtp.sys.beep.pl ([195.245.198.13]:48146 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S266240AbUARLxn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 06:53:43 -0500
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] fix/improve modular IDE (Re: [PATCH] modular IDE for 2.6.1 ugly but working fix)
Date: Sun, 18 Jan 2004 12:52:49 +0100
User-Agent: KMail/1.5.94
Cc: Sam Ravnborg <sam@ravnborg.org>, Witold Krecicki <adasi@kernel.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200401171313.52545.adasi@kernel.pl> <20040117153830.GA3009@mars.ravnborg.org> <200401171702.35705.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200401171702.35705.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200401181252.49861.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia sob 17. stycznia 2004 17:02, Bartlomiej Zolnierkiewicz napisa³:
> On Saturday 17 of January 2004 16:38, Sam Ravnborg wrote:
> > > +ide-core-objs += ide.o ide-default.o ide-io.o ide-iops.o ide-lib.o \
> > > +	ide-probe.o ide-taskfile.o
> >
> > It would be more consistent to use "ide-core-y" since this is
> > what the following lines are expanded to.
> >
> > > +
> > > +ide-core-$(CONFIG_BLK_DEV_CMD640)	+= pci/cmd640.o
> >
> > Like this line.
>
> Yep, thanks!
Could you send updated patch so we could test it?

Also would be nice if ide-detect name was used instead of ide-generic so it 
will be consistent with 2.4 naming.

ps. patch by Witold Krecicki works for other drivers - I've seen it working - 
but it's hacky anyway.
-- 
Arkadiusz Mi¶kiewicz    CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux
