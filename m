Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136314AbRECJrt>; Thu, 3 May 2001 05:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136318AbRECJri>; Thu, 3 May 2001 05:47:38 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:56069 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136314AbRECJrb>; Thu, 3 May 2001 05:47:31 -0400
Subject: Re: [PATCH] adding PCI bus information to SCSI layer
To: cw@f00f.org (Chris Wedgwood)
Date: Thu, 3 May 2001 10:49:02 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        rgooch@ras.ucalgary.ca (Richard Gooch),
        ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser),
        jlundell@pobox.com (Jonathan Lundell), linux-kernel@vger.kernel.org,
        cw@f00f.org
In-Reply-To: <20010503205754.A26313@metastasis.f00f.org> from "Chris Wedgwood" at May 03, 2001 08:57:54 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vFjM-0005Gx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     	open("/dev/ttyF00/speed=9600,clocal");
>     
>     is illegal. That may be a nice way to get much of the desired behaviour without
>     totally breaking compatibility
> 
> Linus has suggested we do something similar in 2.5.x for multiple
> data streams (or forks) in certain filesystems sugh as HFS and
> NTFS... you might want to check the two very similar ideas don't
> collide.

No collisions. There are other good reasons you dont want to do forks on files
that way (you need to enumerate them but if you make them directories all hell
breaks loose).

Alan

