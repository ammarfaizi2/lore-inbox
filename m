Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261349AbTADTim>; Sat, 4 Jan 2003 14:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261338AbTADTim>; Sat, 4 Jan 2003 14:38:42 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:59264
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261337AbTADTil>; Sat, 4 Jan 2003 14:38:41 -0500
Subject: Re: [2.5 patch] re-add zft_dirty to zftape-ctl.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       claus@momo.math.rwth-aachen.de, linux-tape@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20030104151404.GX6114@fs.tum.de>
References: <20030104151404.GX6114@fs.tum.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041712127.2036.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 04 Jan 2003 20:28:48 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-04 at 15:14, Adrian Bunk wrote:
> Hi Alan,
> 
> your
> 
>   [PATCH] rescue ftape from the ravages of that Rusty chap
> 
> removed zft_dirty from zftape-ctl.c in Linus' 2.5 tree. This seems to be
> accidentially and wrong, it was the only definition of zft_dirty in the
> whole kernel sources and now there's an error at the final linking of
> the kernel. The patch below (against 2.5.54) re-adds it.

I disagree entirely. The zft_dirty function is junk. I accidentally missed
removing one other reference to it when you compile it in, that is all. For some
reason the fix to that never got into Linus tree. Remove the other use of it.


Alan

