Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSGMNPK>; Sat, 13 Jul 2002 09:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312938AbSGMNPJ>; Sat, 13 Jul 2002 09:15:09 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:21742 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313113AbSGMNOx>; Sat, 13 Jul 2002 09:14:53 -0400
Subject: Re: IDE/ATAPI in 2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jbradford@dial.pipex.com
Cc: linux-kernel@vger.kernel.org, thunder@ngforever.de, schilling@fokus.gmd.de
In-Reply-To: <200207130636.HAA00666@darkstar.example.net>
References: <200207130636.HAA00666@darkstar.example.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Jul 2002 15:25:28 +0100
Message-Id: <1026570328.9958.83.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-13 at 07:36, jbradford@dial.pipex.com wrote:
> > Because we can't tell Linux users "your (once favorite) CD-ROM is not 
> > implemented in Linux (any more), and will never ever be". If we explicitly 
> > exclude hardware, where do we end?!
> 
> Like other mainstream operating systems :-)
> 
> One thing that occurs to me, but that I don't necessarily think is a good idea,
> is that for a long time we had "old" IDE code and "new" IDE code in the kernel,
> and there is no reason why we couldn't do a similar thing, (I.E. have
> a "legacy devices will work" foo driver, and "legacy devices might 

So we'd have a legacy driver called oh say 'ide-cd' and a current one
called 'ide-scsi'.

How does that change anything ?

