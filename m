Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317844AbSGKN4q>; Thu, 11 Jul 2002 09:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317845AbSGKN4p>; Thu, 11 Jul 2002 09:56:45 -0400
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:27664 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S317844AbSGKN4o>;
	Thu, 11 Jul 2002 09:56:44 -0400
Message-ID: <3D2D8F84.5070107@si.rr.com>
Date: Thu, 11 Jul 2002 10:00:36 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0rc2) Gecko/20020512 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.25 : tr_source_route fix
References: <Pine.LNX.4.44.0207101011580.873-100000@localhost.localdomain> <200207101548.g6AFmUg96842@d12relay01.de.ibm.com> <3D2C64AF.6020102@si.rr.com> <200207111134.34672.arnd@bergmann-dalldorf.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd,
    Please post the 'correct' diff for inclusion. Thanks.

Regards,
Frank

Arnd Bergmann wrote:
> On Wednesday 10 July 2002 18:45, Frank Davis wrote:
> 
> 
>>    I have a few questions regarding your patch. I don't see the line
>>you are removing from net/netsyms.c in 2.5.25 , and for
>>net/llc/llc_mac.c , I also don't see where trdevice.h would be included
>>to make the reference to tr_source_route . Thanks.
> 
> 
> Sorry for the confusion, I was in the wrong branch of my repository when I did 
> the diff.
> trdevice.h should be added to the includes in net/llc/llc_mac.c when removing
> the declaration and net/netsyms.c does indeed not have that line. 
> 
> 	Arnd <><
> 


