Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316662AbSGGX3R>; Sun, 7 Jul 2002 19:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316663AbSGGX3Q>; Sun, 7 Jul 2002 19:29:16 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:23754 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316662AbSGGX3P>; Sun, 7 Jul 2002 19:29:15 -0400
Message-ID: <3D28CF4D.4030702@us.ibm.com>
Date: Sun, 07 Jul 2002 16:31:25 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.name>
CC: Thunder from the hill <thunder@ngforever.de>, Greg KH <greg@kroah.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
References: <Pine.LNX.4.44.0207071551180.10105-100000@hawkeye.luckynet.adm> <3D28C3F0.7010506@us.ibm.com> <200207080123.00487.oliver@neukum.name>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
>>BKL use isn't right or wrong -- it isn't a case of creating a deadlock
>>or a race.  I'm picking a relatively random function from "grep -r
>>lock_kernel * | grep /usb/".  I'll show what I think isn't optimal
>>about it.
> 
> Perhaps, we could agree that the BKL is used wrongly if it
> won't fulfill its presumed function, or fulfills another function
> than the obvious without a comment stating that, or fulfills
> a non obvious function without any comment ?

I wouldn't want to make comments the qualifier for correct use, 
because that makes large chunks of the kernel "wrong" for lack of 
comments.  In a development series we also don't want to restrict 
ourselves to changes of things that are wrong.  We can also improve 
things that are bad.


-- 
Dave Hansen
haveblue@us.ibm.com

