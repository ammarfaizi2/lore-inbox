Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316673AbSGZAE4>; Thu, 25 Jul 2002 20:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316695AbSGZAE4>; Thu, 25 Jul 2002 20:04:56 -0400
Received: from pacific.moreton.com.au ([203.143.238.4]:36074 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S316681AbSGZAEz>; Thu, 25 Jul 2002 20:04:55 -0400
Message-ID: <3D4092F6.9030608@snapgear.com>
Date: Fri, 26 Jul 2002 10:08:22 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: uClinux (MMU-less) patches against 2.5.28
References: <3D3FA130.6020701@snapgear.com> <9309.1027608767@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

David Woodhouse wrote:
> gerg@snapgear.com said:
> 
>> A new set of uClinux (MMU-less) patches agains 2.5.28. You can get it
>>at:
> 
>>http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.28uc0.patch.gz 
> 
> 
> Perhaps drop drivers/block/blkmem.c or justify reinventing the wheel?

Indeed. That blkmem driver is a complete mess.
I can't think of any justification for it existing :-)
I'll work on cleaning that out.

Work is on going to remove the remaining bogosity we are
still carrying in this patch.

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.snapgear.com

