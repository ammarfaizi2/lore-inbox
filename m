Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSDXJS0>; Wed, 24 Apr 2002 05:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310241AbSDXJSZ>; Wed, 24 Apr 2002 05:18:25 -0400
Received: from [195.63.194.11] ([195.63.194.11]:39690 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310190AbSDXJSY>; Wed, 24 Apr 2002 05:18:24 -0400
Message-ID: <3CC669BC.8090208@evision-ventures.com>
Date: Wed, 24 Apr 2002 10:15:56 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: rwhron@earthlink.net
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.9 -- OOPS in IDE code (symbolic dump and boot log included)
In-Reply-To: <20020423205601.A21267@rushmore>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik rwhron@earthlink.net napisa?:
> It sounds like Jens and Martin have a handle on this
> already.  Just in case this helps.  No modules.  

Yeep.

> Oops on 2.5.9 at boot time.

That is indeed a bit surprising. In esp. since the oops happens at boot time.
Maybe some goot order problem.
Could you please introduce two printk("BANG\n") printk("BOOM\n")
aroung the ata_ar_get() in ide-cd? Just to see whatever the
command queue is already up and initialized.

