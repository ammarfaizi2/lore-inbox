Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbUKPHz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbUKPHz1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 02:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUKPHz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 02:55:27 -0500
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:46996 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S261926AbUKPHzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 02:55:22 -0500
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Andreas Schwab <schwab@suse.de>
Date: Tue, 16 Nov 2004 08:55:09 +0100
MIME-Version: 1.0
Subject: Re: CPU hogs ignoring SIGTERM (unkillable processes)
Cc: linux-kernel@vger.kernel.org
Message-ID: <4199C06E.14572.3113A6@rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <jebrdzz0xh.fsf@sykes.suse.de>
References: <4198A766.28114.106DD7B@rkdvmks1.ngate.uni-regensburg.de> (Ulrich Windl's message of "Mon, 15 Nov 2004 12:56:05 +0100")
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-3.84+2.20+2.07.066+02 August 2004+94342@20041116.074342Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Nov 2004 at 14:39, Andreas Schwab wrote:

> "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de> writes:
> 
> > Hello,
> >
> > today I've discovered a programming error in one of my programs (that's fixed 
> > already). When trying to replace the binary, I found out that the processes seem 
> > unaffected by a plain "kill": They just continue to consume CPU. However, a "kill 
> > -9" terminates them. ist that intended behavior? I guess not. Here are some facts:
> 
> Are you sure it doesn't block or ignore the signal?

Andreas,

I don't mess with signals (as said); the code just parses the same area of memory 
again and again (due to a programming error). As offered, you can get the binary 
and the sample command line to repeat (or at the least: try to) situation if you 
like. If I hadn't experienced it, I wouldn't believe myself ;-)

Regards,
Ulrich

