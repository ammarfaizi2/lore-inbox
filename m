Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264361AbTICSbD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 14:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264295AbTICS3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:29:48 -0400
Received: from crete.csd.uch.gr ([147.52.16.2]:7163 "EHLO crete.csd.uch.gr")
	by vger.kernel.org with ESMTP id S264239AbTICS3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:29:17 -0400
Organization: 
Date: Wed, 3 Sep 2003 21:26:06 +0300 (EEST)
From: Panagiotis Papadakos <papadako@csd.uoc.gr>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: IOMEGA ZIP 100 ATAPI problems with 2.6
In-Reply-To: <20030901200530.64ad6fb9.akpm@osdl.org>
Message-ID: <Pine.GSO.4.53.0309032124040.20174@oneiro.csd.uch.gr>
References: <Pine.GSO.4.53.0308310037230.27956@oneiro.csd.uch.gr>
 <3F515301.4040305@sbcglobal.net> <3F532C67.6070904@sbcglobal.net>
 <Pine.GSO.4.53.0309020539380.9075@oneiro.csd.uch.gr> <20030901200530.64ad6fb9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With -mm5 I get the followimg Oops when trying to mount the ZIP

EIP: 0060:[<c025deb4>] Not tainted VLI
....
EIP is at idefloppy_input_buffers+0x34/0x120
....
Call Trace:
[<c025e5a2>] idefloppy_pc_intr+0x212/0x2d0
[<c0127602>] update_one_process+0xb2/0x120
[<c024cb7b>] ide_intr+0xeb/0x190
[<c025e390>] idefloppy_pc_intr+0x0/0x2d0
[<c010c7aa>] handle_IRQ_event+0x3a/0x70
[<c010cb31>] do_IRQ+0x91/0x130
......

Regards
	Panagiotis Papadakos

