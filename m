Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268599AbUHLQHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268599AbUHLQHs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 12:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268597AbUHLQHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 12:07:48 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:41197 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268604AbUHLQGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 12:06:37 -0400
Date: Thu, 12 Aug 2004 18:06:27 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Cc: davem@redhat.com, SteveW@ACM.org, emserrat@geocities.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6: DECNET compile errors with SYSCTL=n
Message-ID: <20040812160627.GM13377@fs.tum.de>
References: <20040811224015.GP26174@fs.tum.de> <20040812.094206.42261287.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040812.094206.42261287.yoshfuji@linux-ipv6.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 09:42:06AM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@ wrote:
> Hello.
> 
> In article <20040811224015.GP26174@fs.tum.de> (at Thu, 12 Aug 2004 00:40:15 +0200), Adrian Bunk <bunk@fs.tum.de> says:
> 
> > I'm getting the following compile errors in 2.6.8-rc4-mm1 (but it 
> > doesn't seem to be specific to -mm) with CONFIG_SYSCTL=n:
> > 
> > <--  snip  -->
> > 
> > ...
> >   LD      .tmp_vmlinux1
> > net/built-in.o(.text+0x1685e9): In function `dn_route_output_slow':
> > : undefined reference to `dn_dev_get_default'
> :
> 
> Please try this patch. Thanks.
>...

Thanks, I can confirm it fixes the compilation.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

