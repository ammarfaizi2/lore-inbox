Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262150AbUKKAGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbUKKAGX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 19:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbUKKAGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 19:06:23 -0500
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:2497 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S262150AbUKKAGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 19:06:03 -0500
Message-ID: <4192ACD9.7000802@am.sony.com>
Date: Wed, 10 Nov 2004 16:05:45 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ncunningham@linuxmail.org
CC: tglx@linutronix.de, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: CELF interest in suspend-to-flash
References: <419256F8.3010305@am.sony.com>	 <1100109991.12290.41.camel@desktop.cunninghams>	 <20041110154136.GA12444@logos.cnet>  <1100115592.3405.36.camel@thomas> <1100116269.3876.12.camel@desktop.cunninghams>
In-Reply-To: <1100116269.3876.12.camel@desktop.cunninghams>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> Hi.
> 
> On Thu, 2004-11-11 at 06:39, Thomas Gleixner wrote:
>> On Wed, 2004-11-10 at 13:41 -0200, Marcelo Tosatti wrote:
>> > Nigel Cunningham wrote:
>> > > 
>> > > Can flash be treated as a swap device at the moment? If so, it might
>> > > simply be a matter of specifying the same parameter used in swapon for
>> > > the resume2= boot parameter.
>> > 
>> > Sure, you only need to have the flash as a block device (ie driven 
>> > by the IDE code).
>> 
>> That's true, if you are talking about Compact FLash which pretends to be
>> a harddisk, but I assume that the embedded people are talking about raw
>> FLASH chips. It's possible do this, but it will need some tweaks to the
>> MTD code

I just heard from a developer at Samsung.
They have successfully used NAND flash as a swap device using MTD.
(on a SMDK2440 platform and SMC NAND flash)
They have not tested NOR flash as swap device.  I'll try to follow up
and see if this translates into something which will work with your
suggested method.

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================
