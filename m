Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVBVRGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVBVRGX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 12:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVBVRGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 12:06:22 -0500
Received: from gsstark.mtl.istop.com ([66.11.160.162]:14477 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S261187AbVBVRGT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 12:06:19 -0500
To: Jens Axboe <axboe@suse.de>
Cc: Greg Stark <gsstark@mit.edu>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jeff Garzik <jgarzik@pobox.com>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi/sata write barrier support
References: <20050127120244.GO2751@suse.de> <87acpxurwf.fsf@stark.xeocode.com>
	<20050222071340.GC2835@suse.de>
In-Reply-To: <20050222071340.GC2835@suse.de>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 22 Feb 2005 12:06:09 -0500
Message-ID: <874qg4v81q.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jens Axboe <axboe@suse.de> writes:

> fsync has been working all along, since the initial barrier support for
> ide. only ext3 and reiserfs support it.

Really? That's huge news. Since what kernel version(s) is that?

What about a non-journaled fs, or at least a meta-data-only-journaled fs?
Journaled FS's don't mix well with transaction based databases since they're
basically doing their own journaling anyways.

-- 
greg

