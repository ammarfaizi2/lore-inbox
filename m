Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbTHTSVZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 14:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbTHTSVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 14:21:21 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:32005 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262128AbTHTSVR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 14:21:17 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: DVD ROM on 2.6
Date: 20 Aug 2003 18:13:03 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bi0dnf$etl$1@gatekeeper.tmr.com>
References: <20030819193456.B25148@animx.eu.org> <20030819202108.A25325@animx.eu.org> <3F437D8A.3040409@lanil.mine.nu> <20030820114719.A26833@animx.eu.org>
X-Trace: gatekeeper.tmr.com 1061403183 15285 192.168.12.62 (20 Aug 2003 18:13:03 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030820114719.A26833@animx.eu.org>,
Wakko Warner  <wakko@animx.eu.org> wrote:
| > >I do have DVDs playing now on 2.6.0-test3.  I used ide-cd instead of
| > >ide-scsi.  apparently the scsi layer didn't like it.
| > >Buffer I/O error on device sr1, logical block 7651
| > >Buffer I/O error on device sr1, logical block 7652
| > >Buffer I/O error on device sr1, logical block 7653
| > >end_request: I/O error, dev sr1, sector 660400
| > >
| > >I would get tons of Buffer I/O errors and some end_requests like the above
| > >
| > I thought ide-scsi was broken?
| 
| I can't tell if this is in the ide-scsi driver or the scsi cdrom driver.  I
| still personally wish that the ide drivers were modules of scsi instead of
| being a seperate block device.  USB storage creates scsi adapters, ide-scsi
| allows ATAPI access via scsi.  Why not do this for ide in general (if that
| starts a flame war, please don't contribute =)

Probably because IDE and ATAPI are not the same thing. There are devices
which electrically connect to the IDE bus which don't speak ATAPI.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
