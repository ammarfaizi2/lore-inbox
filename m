Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965080AbWCUTWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbWCUTWo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 14:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965078AbWCUTWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 14:22:44 -0500
Received: from rtr.ca ([64.26.128.89]:35215 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S965075AbWCUTWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 14:22:42 -0500
Message-ID: <4420527F.5060703@rtr.ca>
Date: Tue, 21 Mar 2006 14:22:39 -0500
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060305 SeaMonkey/1.1a
MIME-Version: 1.0
To: sander@humilis.net
Cc: Linus Torvalds <torvalds@osdl.org>, Mark Lord <lkml@rtr.ca>,
       Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
References: <441F4F95.4070203@garzik.org> <200603210000.36552.lkml@rtr.ca> <20060321121354.GB24977@favonius> <442004E4.7010002@rtr.ca> <20060321153708.GA11703@favonius> <Pine.LNX.4.64.0603211028380.3622@g5.osdl.org> <20060321191547.GC20426@favonius>
In-Reply-To: <20060321191547.GC20426@favonius>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sander wrote:
..
> Btw, it always seems to crash during the md5sum of this test:
> 
> for i in `seq 4`
> do dd if=/dev/zero of=bigfile.$i bs=1024k count=10000
> dd if=bigfile.$i of=/dev/null bs=1024k count=10000
> done
> time md5sum bigfile.*
> time rm bigfile.*
> 
> One time during many tests I needed to run this twice before it went
> bellyup.

The Fed-Ex guy just dropped off a 6081 PCI-X card for me,
so testing here have now gotten a lot easier, as I can now test
drivers on something other than the root filesystem drive.

I'll set things up and try to reproduce those failures here, eventually.

Cheers
