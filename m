Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752172AbWJNO5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbWJNO5u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 10:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752173AbWJNO5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 10:57:50 -0400
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:2709 "EHLO
	aa011msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1752172AbWJNO5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 10:57:49 -0400
Date: Sat, 14 Oct 2006 16:57:49 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Matthias Dahl <mlkernel@mortal-soul.de>
Cc: Jens Axboe <axboe@suse.de>, Mike Galbraith <efault@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: sluggish system responsiveness under higher IO load
Message-ID: <20061014165749.38f59363@localhost>
In-Reply-To: <200610141639.58374.mlkernel@mortal-soul.de>
References: <200608061200.37701.mlkernel@mortal-soul.de>
	<200608131815.12873.mlkernel@mortal-soul.de>
	<20061006175833.4ef08f06@localhost>
	<200610141639.58374.mlkernel@mortal-soul.de>
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.8.19; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Oct 2006 16:39:57 +0200
Matthias Dahl <mlkernel@mortal-soul.de> wrote:

> I will give 2.6.19 a test in a few weeks when the dust of all the changes have 
> settled a bit. :-)

-rc2 is rock solid here, but if you want to wait...

> 
> As my Mike Galbraith suggested, I made some tests with renicing the IO 
> intensive applications. This indeed makes a hell of a difference. Currently I 
> am renicing everything that causes a lot of disk IO to a nice of 19. Even 
> though this doesn't fix it completely, the occasional short hangs have become 
> less common.

Renicing to avoid sluggish system with a simple "cp" or untar is at
best a workaround... so I say: go with .19 and see what happens !

:)

-- 
	Paolo Ornati
	Linux 2.6.19-rc2 on x86_64
