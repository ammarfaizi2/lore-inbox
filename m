Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423564AbWJZPY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423564AbWJZPY7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 11:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423567AbWJZPY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 11:24:59 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:49414 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1423564AbWJZPY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 11:24:58 -0400
Date: Thu, 26 Oct 2006 17:24:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>
Subject: Re: linux-2.6.19-rc2 tg3 problem
Message-ID: <20061026152455.GI27968@stusta.de>
References: <b6a2187b0610230824m38ce6fb2j65cd26099e982449@mail.gmail.com> <20061025013022.GG27968@stusta.de> <b6a2187b0610251754x7dc2c51aoad2244b8cdcb1c09@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6a2187b0610251754x7dc2c51aoad2244b8cdcb1c09@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2006 at 08:54:12AM +0800, Jeff Chua wrote:
> On 10/25/06, Adrian Bunk <bunk@stusta.de> wrote:
> >On Mon, Oct 23, 2006 at 11:24:14PM +0800, Jeff Chua wrote:
> >> I'm getting this error on with linux 2.6.19-rc2 with tg3 module, even
> >> with patching to v3.66 ...
> >> The last version 2.6.18-rc2 works fine. h/w is Dell Optiplex GX620.
> >
> >Known issue, can you confirm the patches below fix it for you?
> 
> I see the patch is for x86_64. I'm on 32bit. And tg3 is compiled as a
> module, so I can't pass pci=routeirq to it. Tried on boot cmdline, but
> doesn't work.

That wasn't clear from your bug report.

You said 2.6.18-rc2 -> 2.6.19-rc2 broke.

Can you identify between which -rc kernels it broke?

Please send complete "dmesg -s 1000000" for the time after tg3 loads for 
both the last working and the first non-working -rc kernel.

> I've tried 2.6.19-rc3, still the same problem.
> 
> Thanks,
> Jeff.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

