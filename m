Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264727AbTE1Mzx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 08:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264728AbTE1Mzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 08:55:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:24246 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264727AbTE1Mzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 08:55:48 -0400
Date: Wed, 28 May 2003 15:08:39 +0200
From: Jens Axboe <axboe@suse.de>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Andrew Morton <akpm@digeo.com>, kernel@kolivas.org,
       matthias.mueller@rz.uni-karlsruhe.de, manish@storadinc.com,
       andrea@suse.de, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030528130839.GW845@suse.de>
References: <3ED2DE86.2070406@storadinc.com> <200305281305.44073.m.c.p@wolk-project.de> <20030528042700.47372139.akpm@digeo.com> <200305281331.26959.m.c.p@wolk-project.de> <20030528125312.GV845@suse.de> <3ED4B49A.4050001@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ED4B49A.4050001@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28 2003, Carl-Daniel Hailfinger wrote:
> Jens Axboe wrote:
> > On Wed, May 28 2003, Marc-Christian Petersen wrote:
> > 
> >>On Wednesday 28 May 2003 13:27, Andrew Morton wrote:
> >>
> >>>Guys, you're the ones who can reproduce this.  Please spend more time
> >>>working out which chunk (or combination thereof) actually fixes the
> >>>problem.  If indeed any of them do.
> >>
> >>As I said, I will test it this evening. ATM I don't have time to
> >>recompile and reboot. This evening I will test extensively, even on
> >>SMP, SCSI, IDE and so on.
> > 
> > May I ask how you are reproducing the bad results? I'm trying in vain
> > here...
> 
> Quoting Con Kolivas:
> 
> dd if=/dev/zero of=dump bs=4096 count=512000

already tried that, no go. on ide/scsi? what filesystem? how much ram?
anything else running? smp/up?

-- 
Jens Axboe

