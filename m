Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268733AbUI3FUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268733AbUI3FUO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 01:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268742AbUI3FUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 01:20:13 -0400
Received: from out009pub.verizon.net ([206.46.170.131]:61319 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S268733AbUI3FUH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 01:20:07 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9-rc3
Date: Thu, 30 Sep 2004 01:20:05 -0400
User-Agent: KMail/1.7
Cc: Tom Duffy <Tom.Duffy@sun.com>
References: <Pine.LNX.4.58.0409292036010.2976@ppc970.osdl.org> <415B93AC.3010502@sun.com>
In-Reply-To: <415B93AC.3010502@sun.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409300120.05524.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.8.60] at Thu, 30 Sep 2004 00:20:06 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 September 2004 01:03, Tom Duffy wrote:
>Linus Torvalds wrote:
>> Ok, this 2.6.9 cycle is getting too long, but here's a -rc3 and
>> hopefully we're getting there now.
>
>   CC [M]  drivers/isdn/capi/capi.o
>/build1/tduffy/linux-2.6.9-rc3/drivers/isdn/capi/capi.c: In function
>`handle_minor_send':
>/build1/tduffy/linux-2.6.9-rc3/drivers/isdn/capi/capi.c:538:
>warning: cast from pointer to integer of different size
>/build1/tduffy/linux-2.6.9-rc3/drivers/isdn/capi/capi.c: In function
>`capi_recv_message':
>/build1/tduffy/linux-2.6.9-rc3/drivers/isdn/capi/capi.c:649:
>error: `tty' undeclared (first use in this function)
>/build1/tduffy/linux-2.6.9-rc3/drivers/isdn/capi/capi.c:649:
>error: (Each undeclared identifier is reported only once
>/build1/tduffy/linux-2.6.9-rc3/drivers/isdn/capi/capi.c:649:
>error: for each function it appears in.)
>make[4]: *** [drivers/isdn/capi/capi.o] Error 1
>make[3]: *** [drivers/isdn/capi] Error 2
>make[2]: *** [drivers/isdn] Error 2
>make[1]: *** [drivers] Error 2
>make: *** [_all] Error 2
>-

Please start from the 2.6.8.tar.gz tarball, Tom.  This looks like you 
may started from the 2.6.8.1.tar.gz.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
