Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313412AbSDLHVB>; Fri, 12 Apr 2002 03:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313413AbSDLHVA>; Fri, 12 Apr 2002 03:21:00 -0400
Received: from h139n1fls24o900.telia.com ([213.66.143.139]:19429 "EHLO
	oden.fish.net") by vger.kernel.org with ESMTP id <S313412AbSDLHU7>;
	Fri, 12 Apr 2002 03:20:59 -0400
Date: Fri, 12 Apr 2002 09:28:38 +0200
From: Voluspa <voluspa@bigfoot.com>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: VFS: Unable to mount root fs on 08:06 - 2.4.19-pre6
Message-Id: <20020412092838.5e617b89.voluspa@bigfoot.com>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002-04-11 14:12:19 Randy Hron wrote:

> This machine worked with 2.4.19-pre5.  2.4.19-pre6 has
> worked on another machine (entirely different hardware). 
>
> Boot message:
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> VFS: Cannot open root device "806" or 08:06
> Please append a correct "root=" boot option
> Kernel panic: VFS: Unable to mount root fs on 08:06 

I had the exact same problem (but much different hardware) with the 2.5.6-pre3 kernel. See:

http://marc.theaimsgroup.com/?l=linux-kernel&m=101548222601049&w=2

It seemed to be preemptive related, but since successive kernels in the 2.5 series worked, I figured they'd fixed things. Now you crash in 2.4 without preempt... Not being a programmer, I'd try CONFIG_SMP=n just to change the playing field (and then prod Alexander Viro ;-)

Regards,
Mats Johannesson
