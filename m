Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751793AbWCABEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbWCABEg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 20:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWCABEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 20:04:35 -0500
Received: from rtr.ca ([64.26.128.89]:48256 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751103AbWCABEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 20:04:34 -0500
Message-ID: <4404F31D.90407@rtr.ca>
Date: Tue, 28 Feb 2006 20:04:29 -0500
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, David Greaves <david@dgreaves.com>,
       Tejun Heo <htejun@gmail.com>, Justin Piszcz <jpiszcz@lucidpixels.com>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>
Subject: Re: LibPATA code issues / 2.6.15.4
References: <Pine.LNX.4.64.0602140439580.3567@p34> <4401122A.3010908@rtr.ca>	 <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca>	 <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com>	 <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com>	 <44046CE6.60803@rtr.ca> <44046D86.7050809@pobox.com> <311601c90602280857x3f102af5l31c9a0ac1a896b4e@mail.gmail.com>
In-Reply-To: <311601c90602280857x3f102af5l31c9a0ac1a896b4e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric D. Mudama wrote:
> those drives should support all FUA opcodes properly, both queued and unqueued

His first drive (sda) does not support queued commands at all,
but the newer firmware in his second drive (sdb) does support NCQ.

Both drives support FUA.

cheers
