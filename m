Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264723AbTE1NQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 09:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264729AbTE1NQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 09:16:56 -0400
Received: from mail.cid.net ([193.41.144.34]:56518 "EHLO mail.cid.net")
	by vger.kernel.org with ESMTP id S264723AbTE1NQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 09:16:56 -0400
Date: Wed, 28 May 2003 15:25:52 +0200
From: Stefan Foerster <stefan@stefan-foerster.de>
To: Jens Axboe <axboe@suse.de>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Andrew Morton <akpm@digeo.com>, kernel@kolivas.org,
       matthias.mueller@rz.uni-karlsruhe.de, manish@storadinc.com,
       andrea@suse.de, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030528132552.GA12914@in-ws-001.cid-net.de>
References: <3ED2DE86.2070406@storadinc.com> <200305281305.44073.m.c.p@wolk-project.de> <20030528042700.47372139.akpm@digeo.com> <200305281331.26959.m.c.p@wolk-project.de> <20030528125312.GV845@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030528125312.GV845@suse.de>
User-Agent: Mutt/1.3.28i
X-Now-Playing: Dusty Springfield - Son of a Preacher Man
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jens Axboe <axboe@suse.de> wrote:
> On Wed, May 28 2003, Marc-Christian Petersen wrote:
>>> Guys, you're the ones who can reproduce this.  Please spend more time
>>> working out which chunk (or combination thereof) actually fixes the
>>> problem.  If indeed any of them do.
>> As I said, I will test it this evening. ATM I don't have time to
>> recompile and reboot. This evening I will test extensively, even on
>> SMP, SCSI, IDE and so on.
> 
> May I ask how you are reproducing the bad results? I'm trying in vain
> here...

It is easily reproducable by using dd with an appropriate blocksize
reading from /dev/zero.

With chunk #3 from Andrew, I do not get pauses, but I noticed text
scrolling in an xterm stopping for like a second.

I did not get any zombie processes.

Ciao
Stefan

