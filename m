Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbTEERUV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 13:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbTEERUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 13:20:21 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:63148 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261329AbTEERUT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 13:20:19 -0400
Date: Mon, 5 May 2003 19:32:30 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 654] New: Floppy access locks system with endless stream
 of errors
In-Reply-To: <9950000.1052152383@[10.10.2.4]>
Message-ID: <Pine.SOL.4.30.0305051932070.27113-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fixed in 2.5.69

On Mon, 5 May 2003, Martin J. Bligh wrote:

> http://bugme.osdl.org/show_bug.cgi?id=654
>
>            Summary: Floppy access locks system with endless stream of errors
>     Kernel Version: 2.5.68-bk11
>             Status: NEW
>           Severity: high
>              Owner: bugme-janitors@lists.osdl.org
>          Submitter: bwindle-kbt@fint.org
>
>
> Distribution: Debian Testing
> Hardware Environment: Dell Optiplex GXa
> Problem Description:
>
> Trying to mount a floppy gives an endless stream of:
> floppy0: disk absent or changed during operation
> end_request: I/O error, dev fd0, sector 0
> floppy0: disk absent or changed during operation
> end_request: I/O error, dev fd0, sector 0
> floppy0: disk absent or changed during operation
> end_request: I/O error, dev fd0, sector 0
>
> The system is non-responsive to changes to VTs, it can't be pinged, but
> alt+sysrq prints "SysRq: Show State" but never prints anything beyond that
> (but  changing LogLevel via Sysrq works).
>
> Ctrl+alt+delete has no effect, numlock won't turn on/off numlock light.
>
> Steps to reproduce:
> Insert floppy, try to mount it.

