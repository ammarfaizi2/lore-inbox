Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262593AbVAVAIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbVAVAIg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 19:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262599AbVAUXZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 18:25:35 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:62382 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S262593AbVAUXXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 18:23:25 -0500
Date: Sat, 22 Jan 2005 00:17:44 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: [patch 0/8] next bunch of IDE fixes (on the way to the driver-model)
Message-ID: <Pine.GSO.4.58.0501220010540.28844@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

All patches are against ide-dev-2.6 tree (== incremental to 5 previous
patches).  The main part of this series is adding reference counting to
IDE device drivers (ide-scsi is a problematic one and I need some help
from SCSI people).

Bartlomiej
