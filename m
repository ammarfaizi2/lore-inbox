Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264877AbUEQAi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264877AbUEQAi7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 20:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbUEQAi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 20:38:27 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:52210 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264877AbUEQAiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 20:38:13 -0400
Date: Mon, 17 May 2004 02:38:09 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.27-pre2: tg3: there's no WARN_ON in 2.4
Message-ID: <20040517003808.GS22742@fs.tum.de>
References: <20040503230911.GE7068@logos.cnet> <200405042253.11133@WOLK> <40982AC6.5050208@eyal.emu.id.au> <20040506121302.GI9636@fs.tum.de> <c7rpsg$ghd$1@terminus.zytor.com> <20040513223436.GI22202@fs.tum.de> <40A3FEB3.3050800@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40A3FEB3.3050800@zytor.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 04:03:15PM -0700, H. Peter Anvin wrote:
> Adrian Bunk wrote:
> >>
> >AFAIR, the -tiny tree already implements some kind of empty 
> >BUG/PAGE_BUG/WARN_ON macros.
> >
> >When optimizing for size that way, your suggestion would result in 
> >bigger code.
> >
> 
> ?!?!?!?!?!
> 
> If there are no side effects, my suggestion produces zero code.
> 
> >And after a quick view, I haven't seen any WARN_ON users in 2.6 that
> >seem to rely on side effects.
> 
> Then there should be no size difference, either.

Ah thanks, now I do understand it.

> 	-hpa

Thanks
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

