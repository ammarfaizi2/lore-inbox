Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262867AbUCJXE2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 18:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262887AbUCJXDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 18:03:37 -0500
Received: from alt.aurema.com ([203.217.18.57]:12466 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S262867AbUCJXBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 18:01:36 -0500
Message-ID: <404F9E28.4040706@aurema.com>
Date: Thu, 11 Mar 2004 10:00:56 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org,
       "Godbole, Amarendra (GE Consumer & Industrial)" 
	<Amarendra.Godbole@ge.com>
Subject: Re: (0 == foo), rather than (foo == 0)
References: <905989466451C34E87066C5C13DDF034593392@HYDMLVEM01.e2k.ad.ge.com>	<20040310100215.1b707504.rddunlap@osdl.org> <Pine.LNX.4.53.0403101324120.18709@chaos>
In-Reply-To: <Pine.LNX.4.53.0403101324120.18709@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Wed, 10 Mar 2004, Randy.Dunlap wrote:
> 
> 
>>On Wed, 10 Mar 2004 11:46:40 +0530 Godbole, Amarendra \(GE Consumer &
>>Industrial\) wrote:
>>
>>Hi,
>>
>>While writing code, the assignment operator (=) is many-a-times
>>confused with the comparison operator (==) resulting in very subtle
>>bugs difficult to track. To keep a check on this -- the constant
>>can be written on the LHS rather than the RHS which will result
>>in a compile time error if wrong operator is used.
>>
> 
> 
> People who develop kernel code know the difference between
> '==' and '=' and are never confused my them.

And you never make typing mistakes?  That's admirable or should I say 
incredible.

> If you make
> contributions to kernel code, and write: "if (0==foo)", your
> code will be reviewed until it is obsolete and never find
> its way into the kernel. Please don't insult kernel developers
> with this kind of kid-stuff.
> 
> People who develop kernel code also know what a line-warp is.
> They put a '\n' "[Enter] key" in their text every so-often,
> maybe every 70 to 79 characters...
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
>             Note 96.31% of all statistics are fiction.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

