Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264728AbTE1NQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 09:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264729AbTE1NQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 09:16:58 -0400
Received: from mail.cid.net ([193.41.144.34]:56774 "EHLO mail.cid.net")
	by vger.kernel.org with ESMTP id S264728AbTE1NQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 09:16:56 -0400
Date: Wed, 28 May 2003 15:27:58 +0200
From: Stefan Foerster <stefan@stefan-foerster.de>
To: Jens Axboe <axboe@suse.de>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Andrew Morton <akpm@digeo.com>, kernel@kolivas.org,
       matthias.mueller@rz.uni-karlsruhe.de, manish@storadinc.com,
       andrea@suse.de, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030528132758.GB12914@in-ws-001.cid-net.de>
References: <3ED2DE86.2070406@storadinc.com> <200305281305.44073.m.c.p@wolk-project.de> <20030528042700.47372139.akpm@digeo.com> <200305281331.26959.m.c.p@wolk-project.de> <20030528125312.GV845@suse.de> <3ED4B49A.4050001@gmx.net> <20030528130839.GW845@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030528130839.GW845@suse.de>
User-Agent: Mutt/1.3.28i
X-Now-Playing: Dusty Springfield - Son of a Preacher Man
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jens Axboe <axboe@suse.de> wrote:
> On Wed, May 28 2003, Carl-Daniel Hailfinger wrote:
>> dd if=/dev/zero of=dump bs=4096 count=512000
> 
> already tried that, no go. on ide/scsi? what filesystem? how much ram?
> anything else running? smp/up?

Doesn't matter if IDE or SCSI, to be honest, SCSI with the old aic7xxx
from vanilla 2.4.20 is even worse than IDE.

My box is up, had only my window manager with some open xterms
running, nothing which should create any load.


Ciao
Stefan
-- 
Stefan Förster                                  Public Key: 0xBBE2A9E9
FdI #122: Updateritis - Softwarebulemie (Frank Klemm)

