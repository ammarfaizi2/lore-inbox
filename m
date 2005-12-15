Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965174AbVLOIPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965174AbVLOIPU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 03:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965175AbVLOIPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 03:15:20 -0500
Received: from odin2.bull.net ([192.90.70.84]:43668 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S965174AbVLOIPU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 03:15:20 -0500
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: art@usfltd.com
Subject: Re: kernel-2.6.15-rc5-rt2 - compilation error =?iso-8859-1?q?=91RWSEM=5FACTIVE=5FBIAS=92?= undeclared
Date: Thu, 15 Dec 2005 09:20:49 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
References: <200512141157.AA15073854@usfltd.com>
In-Reply-To: <200512141157.AA15073854@usfltd.com>
MIME-Version: 1.0
Message-Id: <200512150920.49497.Serge.Noiraud@bull.net>
X-MIMETrack: Itemize by SMTP Server on ANN-002/FR/BULL(Release 5.0.11  |July 24, 2002) at
 15/12/2005 09:16:18,
	Serialize by Router on ANN-002/FR/BULL(Release 5.0.11  |July 24, 2002) at
 15/12/2005 09:16:23,
	Serialize complete at 15/12/2005 09:16:23
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same problem here on x86 architecture.
It already exists with rt1.

mercredi 14 Décembre 2005 18:57, art wrote/a écrit :
> 
> kernel-2.6.15-rc5-rt2 - compilation error ‘RWSEM_ACTIVE_BIAS’ undeclared
> 
> gcc version 4.0.2
> ........
>   CC      lib/kref.o
>   CC      lib/prio_tree.o
>   CC      lib/radix-tree.o
>   CC      lib/rbtree.o
>   CC      lib/rwsem.o
> lib/rwsem.c: In function ‘__rwsem_do_wake’:
> lib/rwsem.c:57: warning: implicit declaration of function ‘rwsem_atomic_update’
> lib/rwsem.c:57: error: ‘RWSEM_ACTIVE_BIAS’ undeclared (first use in this function)
> lib/rwsem.c:57: error: (Each undeclared identifier is reported only once
> lib/rwsem.c:57: error: for each function it appears in.)
> lib/rwsem.c:59: error: ‘RWSEM_ACTIVE_MASK’ undeclared (first use in this function)
...
