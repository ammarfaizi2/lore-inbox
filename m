Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263952AbTHBNLP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 09:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263997AbTHBNLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 09:11:15 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:20156 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263952AbTHBNLJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 09:11:09 -0400
Date: Sat, 2 Aug 2003 15:10:43 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Erik Andersen <andersen@codepoet.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ide-disk.c rev 1.13 killed CONFIG_IDEDISK_STROKE
In-Reply-To: <20030802124536.GB3689@win.tue.nl>
Message-ID: <Pine.SOL.4.30.0308021506550.7779-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 2 Aug 2003, Andries Brouwer wrote:

> Maybe it is intended to protect against old disks that do not
> understand these new commands. Andre? Bart? Alan?

Some Samsung disks lock up.  Probably we should check if HPA
command set is supported instead of using IDE_STROKE_LIMIT.

--
Bartlomiej

