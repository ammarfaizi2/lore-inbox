Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265039AbSJPPa5>; Wed, 16 Oct 2002 11:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265040AbSJPPa5>; Wed, 16 Oct 2002 11:30:57 -0400
Received: from pacific.moreton.com.au ([203.143.238.4]:6406 "EHLO
	doughboy.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S265039AbSJPPa4>; Wed, 16 Oct 2002 11:30:56 -0400
Message-ID: <3DAD8768.1070706@snapgear.com>
Date: Thu, 17 Oct 2002 01:36:08 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: linux-2.5.42uc1 (MMU-less support)
References: <3DAC337D.7010804@snapgear.com> <20021015181609.A31647@infradead.org> <3DAD7AA9.1060207@snapgear.com> <20021016154842.A13211@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>>This isn't old. It is the primary format used on uClinux. ELF
>>and a.out are not practical, since you would need to do the final
>>link/locate on them at exec load time (you won't know what address
>>in memory they will get loaded to until them). You don have the
>>VM luxary of just locating it at a fixed address at compile time.
>>
>>FLAT format is a light weight, mostly architecture independant
>>way to carry around relocs, and to keep the program binaries
>>small.
>>
> 
> I don't meant binfmt_flat itself but the support for the old-style relocs
> that is still in the code.


OK, I'll have a look at that.


> BTW, does binfmt_flat for for any non-uClinux port?


Don't beleive so.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

