Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264725AbTE1MyW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 08:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264726AbTE1MyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 08:54:22 -0400
Received: from mail.gmx.de ([213.165.64.20]:32897 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264725AbTE1MyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 08:54:20 -0400
Message-ID: <3ED4B49A.4050001@gmx.net>
Date: Wed, 28 May 2003 15:07:38 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Andrew Morton <akpm@digeo.com>, kernel@kolivas.org,
       matthias.mueller@rz.uni-karlsruhe.de, manish@storadinc.com,
       andrea@suse.de, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
References: <3ED2DE86.2070406@storadinc.com> <200305281305.44073.m.c.p@wolk-project.de> <20030528042700.47372139.akpm@digeo.com> <200305281331.26959.m.c.p@wolk-project.de> <20030528125312.GV845@suse.de>
In-Reply-To: <20030528125312.GV845@suse.de>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Wed, May 28 2003, Marc-Christian Petersen wrote:
> 
>>On Wednesday 28 May 2003 13:27, Andrew Morton wrote:
>>
>>>Guys, you're the ones who can reproduce this.  Please spend more time
>>>working out which chunk (or combination thereof) actually fixes the
>>>problem.  If indeed any of them do.
>>
>>As I said, I will test it this evening. ATM I don't have time to
>>recompile and reboot. This evening I will test extensively, even on
>>SMP, SCSI, IDE and so on.
> 
> May I ask how you are reproducing the bad results? I'm trying in vain
> here...

Quoting Con Kolivas:

dd if=/dev/zero of=dump bs=4096 count=512000


HTH,
Carl-Daniel

