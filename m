Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263707AbUDODy4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 23:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263724AbUDODy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 23:54:56 -0400
Received: from selene.LaTech.edu ([138.47.18.25]:24271 "EHLO LaTech.edu")
	by vger.kernel.org with ESMTP id S263707AbUDODyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 23:54:52 -0400
Message-ID: <1082001287.407e0787f3c48@webmail.LaTech.edu>
Date: Wed, 14 Apr 2004 22:54:47 -0500
From: Ryan Geoffrey Bourgeois <rgb005@latech.edu>
To: Konstantin Sobolev <kos@supportwizard.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: poor sata performance on 2.6
References: <200404150236.05894.kos@supportwizard.com>
In-Reply-To: <200404150236.05894.kos@supportwizard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2 / FreeBSD-4.8
X-Originating-IP: 138.47.118.132
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Konstantin Sobolev <kos@supportwizard.com>:

> /dev/hde:
>  Timing buffer-cache reads:   1436 MB in  2.00 seconds = 717.03 MB/sec
>  Timing buffered disk reads:  100 MB in  3.03 seconds =  32.95 MB/sec
> 
> for sata_sil:
> 
> /dev/sda:
>  Timing buffer-cache reads:   1412 MB in  2.00 seconds = 705.05 MB/sec
>  Timing buffered disk reads:   84 MB in  3.06 seconds =  27.43 MB/sec
> 
> So my old IDE HDD appears to be considerably faster. Expected results were 
> 55-70MB/s.


Which kernel version did you get these results using?  Have you speed-tested the
drive(s) on a different SATA controller?  I don't mean to imply that you should
buy another one - that would be rediculuous since your motherboard should
laready has it - but it would help to eliminate possible causes of error.  I
took the same readings on my machine.  I'm using an ASUS SK8N motherboard -
that's the Promise TX2 SATA controller - with Western Digital's 36gb 10K RPM
Raptor:

/dev/sda:
 Timing buffer-cache reads:   128 MB in  0.12 seconds =1075.79 MB/sec
 Timing buffered disk reads:  64 MB in  1.20 seconds = 53.43 MB/sec

I'm using the latest stable vanilla kernel (2.6.5), compiled today.  It would
also help to have your kernel config, if at all possible.

-Ryan

-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/

