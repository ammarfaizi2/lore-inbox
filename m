Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266815AbSKHRJu>; Fri, 8 Nov 2002 12:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266814AbSKHRJu>; Fri, 8 Nov 2002 12:09:50 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:32668 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266815AbSKHRJt>; Fri, 8 Nov 2002 12:09:49 -0500
Subject: Re: [PATCH] Update powermac IDE driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Mackerras <paulus@samba.org>
Cc: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       benh@kernel.crashing.org
In-Reply-To: <15817.54051.309679.395892@argo.ozlabs.ibm.com>
References: <15817.54051.309679.395892@argo.ozlabs.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Nov 2002 17:39:40 +0000
Message-Id: <1036777180.16651.45.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-07 at 02:42, Paul Mackerras wrote:
> This patch updates the powermac IDE driver in 2.5 so it uses the 2.5
> kernel interfaces and types rather than the 2.4 ones.  It also makes
> it use blk_rq_map_sg rather than its own code to set up scatter/gather
> lists in pmac_ide_build_sglist, and makes it use ide_lock instead of
> io_request_lock.

Ok with me as IDE maintainer

