Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTE2P6Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 11:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbTE2P6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 11:58:15 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:44809 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262328AbTE2P6O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 11:58:14 -0400
Date: Thu, 29 May 2003 18:10:36 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Willy Tarreau <willy@w.ods.org>, Andrea Arcangeli <andrea@suse.de>,
       Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@digeo.com>,
       axboe@suse.de, m.c.p@wolk-project.de, manish@storadinc.com,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030529161036.GB4985@pcw.home.local>
References: <3ED2DE86.2070406@storadinc.com> <20030528101348.GA804@rz.uni-karlsruhe.de> <20030528032315.679e77b0.akpm@digeo.com> <200305290000.12116.kernel@kolivas.org> <20030529132431.GK1453@dualathlon.random> <20030529135508.GC21673@alpha.home.local> <20030529143827.GA777@rz.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030529143827.GA777@rz.uni-karlsruhe.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 04:38:28PM +0200, Matthias Mueller wrote:
 
> I run fluxbox, not a very heavy window manager, but I installed ctwm and
> tried again with vanilla 2.4.20. If I disabled swap the short hangs (1s) are
> gone, but the long mouse hangs (10s) are still there.

Thanks for the test, but I find it really amazing that the mouse hangs while
it has nothing to do with any block device at all !

Cheers,
Willy

