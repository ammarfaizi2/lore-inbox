Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbUEVPWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbUEVPWr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 11:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbUEVPWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 11:22:47 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:39299 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261580AbUEVPWm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 11:22:42 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jan Meizner <jm@pa103.nowa-wies.sdi.tpnet.pl>,
       system <system@eluminoustechnologies.com>
Subject: Re: hda Kernel error!!!
Date: Sat, 22 May 2004 17:24:46 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <200405221257.28570.system@eluminoustechnologies.com> <Pine.LNX.4.55L.0405221515410.32669@pa103.nowa-wies.sdi.tpnet.pl>
In-Reply-To: <Pine.LNX.4.55L.0405221515410.32669@pa103.nowa-wies.sdi.tpnet.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405221724.47059.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 of May 2004 15:29, Jan Meizner wrote:
> On Sat, 22 May 2004, system wrote:
> > Hello All,
> >  In that I found warning about kernel error!!
> >
> > WARNING:  Kernel Errors Present
> >    hda: drive_cmd: error=0x04 { DriveStat...:  1Time(s)
> >    hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }...: 
> > 1Time(s)
> >
> > What is this error?
> > Dose this indicate error on hda?
> > Should I replace hda?OR it's different from all these?
> > Please help thank you...
>
> Mayby I'm not kernel expert yet, but IMVHO it looks like hardware (hard
> drive) problem.

Quite the opposite.  It only means that command was aborted.

This frequently happens on older devices under 2.4 and is usually harmless.
[ This issue was discussed few times already. ]


