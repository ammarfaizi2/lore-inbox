Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264877AbUEVBOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264877AbUEVBOW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 21:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264804AbUEVBLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 21:11:38 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:33216 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264798AbUEVBJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 21:09:11 -0400
Date: Thu, 20 May 2004 11:02:18 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andreas Hartmann <andihartmann@01019freenet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm4
Message-ID: <20040520090218.GH24287@fs.tum.de>
References: <fa.h0r5q8q.k6meb8@ifi.uio.no> <c8hgk0$336$1@p3EE062C3.dip0.t-ipconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8hgk0$336$1@p3EE062C3.dip0.t-ipconnect.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2004 at 07:44:32AM +0200, Andreas Hartmann wrote:
> Hello!
> 
> I got a compile error compiling the following:
> 
>   LD      .tmp_vmlinux1
> arch/i386/kernel/built-in.o(.text+0x1247f): In function 
> `hpet_rtc_interrupt':
> : undefined reference to `rtc_interrupt'
> arch/i386/kernel/built-in.o(.text+0x124aa): In function 
> `hpet_rtc_interrupt':
> : undefined reference to `rtc_get_rtc_time'
> make: *** [.tmp_vmlinux1] Error 1
> 
> I switched on 'HPET Timer Support' and 'Provide RTC interrupt'
> It works fine without 'Provide RTC interrupt'.
>...

Please send your complete .config .

> Regards,
> Andreas Hartmann

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

