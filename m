Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267768AbUHPPcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267768AbUHPPcE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 11:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267743AbUHPPby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 11:31:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41707 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267768AbUHPPbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 11:31:11 -0400
Date: Mon, 16 Aug 2004 11:30:11 -0400
From: Alan Cox <alan@redhat.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: PATCH: switch ide-proc to use the ide_key functionality
Message-ID: <20040816153011.GE10279@devserv.devel.redhat.com>
References: <20040815150414.GA12181@devserv.devel.redhat.com> <200408161724.09880.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408161724.09880.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 05:24:09PM +0200, Bartlomiej Zolnierkiewicz wrote:
> This patch removes write access to /proc/ide/hd?/driver without even
> mentioning this - IMHO we should deprecate it first.  Such changes should
> be described (with rationale for them) at least in the changelog
> (or even better in Documentation/ide.txt).

I thought we discussed this earlier - its essentially unfixable. You can
either have trivial /proc crashes, deadlocks on writing this file or lose
the feature (which nobody on the planet even knew about). 

If you've got any ideas how to fix it then let me know.

Agreed about adding it to Documentation/ide.txt

