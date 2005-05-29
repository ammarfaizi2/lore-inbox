Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVE2QEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVE2QEI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 12:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVE2QEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 12:04:08 -0400
Received: from oldconomy.demon.nl ([212.238.217.56]:32182 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S261345AbVE2QEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 12:04:05 -0400
Subject: Re: Playing with SATA NCQ
From: Erik Slagter <erik@slagter.name>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>
In-Reply-To: <20050526140058.GR1419@suse.de>
References: <20050526140058.GR1419@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 29 May 2005 18:03:18 +0200
Message-Id: <1117382598.4851.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-26 at 16:00 +0200, Jens Axboe wrote:
> Now, this patch is not complete. It should work and work well, but error
> handling isn't really tested or finished yet (by any stretch of the
> imagination). So don't use this on a production machine, it _should_ be
> safe to use on your test boxes and for-fun workstations though (I run it
> here...). I have tested on ich6 and ich7 generation ahci, and with
> Maxtor and Seagate drives.

Is this supposed to work on ICH7 in legacy mode as well?

Another question: is there a fundamental problem to have the ICH6/7
enabled AHCI mode by the kernel instead of the BIOS? I know some BIOSes
don't offer the choice to enable AHCI (like mine :-().
