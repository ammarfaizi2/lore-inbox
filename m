Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266245AbUALWZU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 17:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265632AbUALWZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 17:25:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2209 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266276AbUALWZJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 17:25:09 -0500
Message-ID: <40031EB1.5030705@pobox.com>
Date: Mon, 12 Jan 2004 17:24:49 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Andreas Haumer <andreas@xss.co.at>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [2.4 patch] disallow modular CONFIG_COMX
References: <Pine.LNX.4.58L.0312311109131.24741@logos.cnet> <3FF2EAB3.1090001@xss.co.at> <20040111013043.GY25089@fs.tum.de>
In-Reply-To: <20040111013043.GY25089@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Wed, Dec 31, 2003 at 04:26:43PM +0100, Andreas Haumer wrote:
> 
>>...
>>Hi!
> 
> 
> Hi Andreas!
> 
> 
>>...
>>Here's a first report:
>>...
>>*) Unresolved symbol in kernel/drivers/net/wan/comx.o: proc_get_inode
>>...
> 
> 
> CONFIG_COMX=m always gave an unresolved symbol in kernel 2.4, and it
> seems noone is interested in properly fixing it.
> 
> The patch below disallows a modular CONFIG_COMX.

I agree with the intent...

At this point, I am tempted to simply comment it out of the Config.in, 
and let interested parties backport bug fixes and crap from 2.6 if they 
would like.  The driver has had obvious bugs for a while...

	Jeff



