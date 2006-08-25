Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWHYKvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWHYKvB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 06:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWHYKvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 06:51:01 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:50187 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751439AbWHYKvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 06:51:00 -0400
Date: Fri, 25 Aug 2006 12:50:59 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] Add __global tag where needed.
Message-ID: <20060825105059.GX19810@stusta.de>
References: <1156429585.3012.58.camel@pmac.infradead.org> <1156433212.3012.120.camel@pmac.infradead.org> <20060824213047.GR19810@stusta.de> <1156499546.2984.43.camel@pmac.infradead.org> <20060825102649.GU19810@stusta.de> <1156502078.2984.81.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156502078.2984.81.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 11:34:38AM +0100, David Woodhouse wrote:
> On Fri, 2006-08-25 at 12:26 +0200, Adrian Bunk wrote:
>...
> > But projects like embedded systems or OLPC that really need want 
> > kernels should be the same projects that already avoid the
> > 10% size penalty of CONFIG_MODULES=y.
> 
> OLPC has USB ports and wants to be fairly flexible about being able to
> connect stuff -- I don't think we can turn off CONFIG_MODULES in its
> running kernel.
>...

You can compile many USB modules statically into the kernel before 
using more additional space than what CONFIG_MODULES=n saves today.

> dwmw2

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

