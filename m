Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbTKLP1L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 10:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbTKLP1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 10:27:11 -0500
Received: from misc-out.ouvaton.net ([80.67.180.36]:60626 "EHLO
	mx1.ouvaton.net") by vger.kernel.org with ESMTP id S262101AbTKLP1J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 10:27:09 -0500
Message-ID: <50269.213.41.151.68.1068650822.squirrel@ssl.ouvaton.coop>
Date: Wed, 12 Nov 2003 16:27:02 +0100 (CET)
Subject: Re: ide-scsi: 'Sleeping function called from invalid context', 2.6.0-test9
From: <obdk65536@ouvaton.org>
To: <vms@bofhlet.net>
In-Reply-To: <20031112080119.GD21265@home.bofhlet.net>
References: <20031112080119.GD21265@home.bofhlet.net>
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.12[cvs])
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Oh wonderful.  It has happenned to me, too, test9, Slackware 9.1,
> cdrecord 2.0a19 (same as yours).  I think there's a problem with DMA -
> it wasnt' enabled when this happened.  When I enabled it, CD's burned
> normally.  And this happened only when I built SCSI support (sg, sr_mod)
> as modules.. when in core, DMA is enabled automatically and _stays_
> enabled...

Mine is in core.  And it's using DMA according to /proc/ide/hdc/settings.
--
Berke Durak



