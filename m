Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316342AbSGLSxJ>; Fri, 12 Jul 2002 14:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316803AbSGLSxH>; Fri, 12 Jul 2002 14:53:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39183 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316342AbSGLSws>; Fri, 12 Jul 2002 14:52:48 -0400
Message-ID: <3D2F261D.4020400@zytor.com>
Date: Fri, 12 Jul 2002 11:55:25 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020524
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cantab.net>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Martin Dalecki <dalecki@evision-ventures.com>,
       linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
References: <Pine.LNX.4.44.0207121050230.14359-100000@home.transmeta.com> <5.1.0.14.2.20020712194731.044115f0@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
>>
>> Then *please* make a *compatible* interface available to user space. 
>> This certainly can be done; the parallel port IDE interface stuff had 
>> exactly such an interface (/dev/pg*) -- we could have a /dev/hg* 
>> interface presumably.  That is an acceptable solution. 
> 
> But Linus is wanting exactly that! As far as I understand, Linus would 
> like a generic interface sitting at the higher layers, and that is used 
> by the ide/atapi/scsi layers. I read this as implying that the user 
> space interface will also be only one. It will talk to the higher 
> layers, the lower layers can then do all the hw specific magic.
> 

That's fine with me.

	-hpa


