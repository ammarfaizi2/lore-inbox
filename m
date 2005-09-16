Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbVIPUEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVIPUEd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 16:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbVIPUEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 16:04:33 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:10376 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1750809AbVIPUEc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 16:04:32 -0400
Message-ID: <432B254C.209@gmail.com>
Date: Fri, 16 Sep 2005 22:04:28 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Kay Sievers <kay.sievers@vrfy.org>
CC: Dominik Karall <dominik.karall@gmx.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: 2.6.14-rc1-mm1
References: <20050916022319.12bf53f3.akpm@osdl.org> <200509162042.07376.dominik.karall@gmx.net> <432B2101.9080806@gmail.com> <20050916195903.GE22221@vrfy.org>
In-Reply-To: <20050916195903.GE22221@vrfy.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kay Sievers napsal(a):
> On Fri, Sep 16, 2005 at 09:46:09PM +0200, Jiri Slaby wrote:
>>I have the same problem. Version 2.6.13-mm3 was OK and the new version 
>>was only oldconfigured. When I create appropriate devices with mknod, it 
>>is ok. So why does not udev (58 and 70) create that devices (event, 
>>mice, mouse, wacom)?
> 
> 
> There is no userspace support(udev, libsysfs, HAL) for the experimental
> sysfs layout of the input layer patches. We better remove them until we
> all can agree on a sane layout. I don't expect it will make it into the
> kernel it its current form.
I see the changes now, thanks for your quick reply.

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10
