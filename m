Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbTEHOjT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 10:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbTEHOjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 10:39:19 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:28349 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261704AbTEHOjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 10:39:18 -0400
Date: Thu, 8 May 2003 16:51:44 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 ide 48-bit usage
Message-ID: <20030508145144.GC20941@suse.de>
References: <20030508132314.GZ823@suse.de> <Pine.SOL.4.30.0305081532170.12362-100000@mion.elka.pw.edu.pl> <20030508133702.GC823@suse.de> <20030508144712.GB20941@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508144712.GB20941@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08 2003, Jens Axboe wrote:
> that for now. It _is_ essentially two seperate issues, right? One is
> getting good request sizes on 48-bit commands, the other is taking some
> decent advantage of 48-bit commands.

That came out totally wrong :-)

One issue is getting good request sizes on 48-bit commands (ie taking
advantage of 48-bit commands). The other issue, which I left out, is
cutting 48-bit lba overhead by not using it when not necessary. The
attached patch deals with the former issue, obviously.

-- 
Jens Axboe

