Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272288AbTG3Vpa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 17:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272289AbTG3Vpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 17:45:30 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:9633 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S272288AbTG3VpZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 17:45:25 -0400
Date: Wed, 30 Jul 2003 23:45:01 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Pavel Machek <pavel@ucw.cz>
cc: <alan@redhat.com>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Warn about taskfile?
In-Reply-To: <20030730205935.GA238@elf.ucw.cz>
Message-ID: <Pine.SOL.4.30.0307302336410.1566-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Jul 2003, Pavel Machek wrote:

> Hi!
>
> I had some strange fs corruption, and andi suggested that it probably
> is TASKFILE-related. Perhaps this is good idea?

Idea is good.

Did corruption go away after disabling taskfile?
Taskfile was by default on for 2.5.72 and 2.5.73 and Andi's unexplained
x86-64 + AMD8111 corruption was the only one reported to me / on lkml.

dmesg and hdparm /dev/scratchdisk for a start, please.

--
Bartlomiej

