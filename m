Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbTE2QLA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 12:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbTE2QLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 12:11:00 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:31752 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262403AbTE2QKj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 12:10:39 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Andrew Morton <akpm@digeo.com>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Date: Thu, 29 May 2003 18:23:12 +0200
User-Agent: KMail/1.5.2
Cc: axboe@suse.de, kernel@kolivas.org, matthias.mueller@rz.uni-karlsruhe.de,
       andrea@suse.de, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
References: <3ED2DE86.2070406@storadinc.com> <20030528042700.47372139.akpm@digeo.com> <200305281331.26959.m.c.p@wolk-project.de>
In-Reply-To: <200305281331.26959.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200305291811.59762.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 May 2003 13:31, Marc-Christian Petersen wrote:

Hi Andrew,

> > Guys, you're the ones who can reproduce this.  Please spend more time
> > working out which chunk (or combination thereof) actually fixes the
> > problem.  If indeed any of them do.
> As I said, I will test it this evening. ATM I don't have time to recompile
> and reboot. This evening I will test extensively, even on SMP, SCSI, IDE
> and so on.
Sorry, haven't had any time yesterday.

So my 10¢ comment for the patches (like the ones in -rc6).

1. Braindead pausings are GONE (mouse is not sticky as w/o the patch).
2. Mouse sticks are still there rarely (short ones, max. 1 second)
    (If one can say 1 second is short ...).
3. all three patches are needed.

No side effects yet tho. Works with SCSI, IDE and SMP.

ciao, Marc

