Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbTE1MzZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 08:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264727AbTE1MzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 08:55:25 -0400
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:6163 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id S264726AbTE1MzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 08:55:20 -0400
Date: Wed, 28 May 2003 14:58:03 +0200
From: Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
To: Jens Axboe <axboe@suse.de>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Andrew Morton <akpm@digeo.com>, kernel@kolivas.org,
       manish@storadinc.com, andrea@suse.de, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030528125803.GB714@rz.uni-karlsruhe.de>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	Andrew Morton <akpm@digeo.com>, kernel@kolivas.org,
	manish@storadinc.com, andrea@suse.de, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
References: <3ED2DE86.2070406@storadinc.com> <200305281305.44073.m.c.p@wolk-project.de> <20030528042700.47372139.akpm@digeo.com> <200305281331.26959.m.c.p@wolk-project.de> <20030528125312.GV845@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030528125312.GV845@suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28, 2003 at 02:53:12PM +0200, Jens Axboe wrote:
> May I ask how you are reproducing the bad results? I'm trying in vain
> here...

I can reproduce it with dd if=/dev/zero of=trash bs=4096 count=65000 on my
notebook (probably a slower harddisk makes it easier to see the mouse
hangs).

Matthias
