Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263977AbSKVNCU>; Fri, 22 Nov 2002 08:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264714AbSKVNCU>; Fri, 22 Nov 2002 08:02:20 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:24204 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263977AbSKVNCS>; Fri, 22 Nov 2002 08:02:18 -0500
Subject: Re: Where is ext2/3 secure delete ("s") attribute?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kentborg@borg.org
In-Reply-To: <3DDD88BB.209@pobox.com>
References: <200211220122.gAM1MQY305783@saturn.cs.uml.edu> 
	<3DDD88BB.209@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Nov 2002 13:38:28 +0000
Message-Id: <1037972308.11846.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-22 at 01:30, Jeff Garzik wrote:
> Albert D. Cahalan wrote:
> 
> > Forget the shred program. It's less useful than having the
> > filesystem simply zero the blocks, because it's slow and you
> > can't be sure to hit the OS-visible blocks.
> 
> 
> Why not?
> 
> Please name a filesystem that moves allocated blocks around on you.  And 
> point to code, too.

Anything on IDE or SCSI or Flash. Just its done below you

