Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264291AbTICSfA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 14:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264259AbTICSdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:33:46 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:12720 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264127AbTICScx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:32:53 -0400
Date: Wed, 3 Sep 2003 20:32:42 +0200
From: Jens Axboe <axboe@suse.de>
To: Panagiotis Papadakos <papadako@csd.uoc.gr>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: IOMEGA ZIP 100 ATAPI problems with 2.6
Message-ID: <20030903183242.GH838@suse.de>
References: <Pine.GSO.4.53.0308310037230.27956@oneiro.csd.uch.gr> <3F515301.4040305@sbcglobal.net> <3F532C67.6070904@sbcglobal.net> <Pine.GSO.4.53.0309020539380.9075@oneiro.csd.uch.gr> <20030901200530.64ad6fb9.akpm@osdl.org> <Pine.GSO.4.53.0309032124040.20174@oneiro.csd.uch.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.53.0309032124040.20174@oneiro.csd.uch.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03 2003, Panagiotis Papadakos wrote:
> With -mm5 I get the followimg Oops when trying to mount the ZIP
> 
> EIP: 0060:[<c025deb4>] Not tainted VLI
> ...
> EIP is at idefloppy_input_buffers+0x34/0x120
> ...
> Call Trace:
> [<c025e5a2>] idefloppy_pc_intr+0x212/0x2d0
> [<c0127602>] update_one_process+0xb2/0x120
> [<c024cb7b>] ide_intr+0xeb/0x190
> [<c025e390>] idefloppy_pc_intr+0x0/0x2d0
> [<c010c7aa>] handle_IRQ_event+0x3a/0x70
> [<c010cb31>] do_IRQ+0x91/0x130

Would it be possible to get the entire oops? I'm sure I can fix the bug,
it would be best if we could talk with lower latency than a few days
(otherwise just 2-3 patch iterations will last a week :)

-- 
Jens Axboe

