Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267795AbUG3THP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267795AbUG3THP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 15:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267788AbUG3THP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 15:07:15 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:41439 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267796AbUG3TG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 15:06:28 -0400
Date: Fri, 30 Jul 2004 21:06:21 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Nicolas Boichat <nicolas@boichat.ch>
Cc: Andrew Morton <akpm@osdl.org>,
       Grega Fajdiga <Gregor.Fajdiga@guest.arnes.si>,
       linux-kernel@vger.kernel.org
Subject: Re: Compile error in 2.6.8-rc2-mm1 - rivafb related
Message-ID: <20040730190620.GB685@fs.tum.de>
References: <1091105305.11537.6.camel@cable155-82.ljk.voljatel.net> <20040730141441.GA685@fs.tum.de> <1091203618.6583.7.camel@tom>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091203618.6583.7.camel@tom>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2004 at 06:06:58PM +0200, Nicolas Boichat wrote:

> Hello,

Hi Nicolas,
 
> On Fri, 2004-07-30 at 16:14, Adrian Bunk wrote:
>...
> > @Nicolas:
> > Your rivafb-i2c-fixes patch in -mm causes this with CONFIG_FB_RIVA_I2C=n 
> > (it moves i2c code from inside an #ifdef CONFIG_FB_RIVA_I2C to a place 
> > where it isn't guarded by such an #ifdef).
> 
> It seems that a wrong patch (an older one) has been integrated in -mm.
> 
> I attached the right patch, that I already sent on July 14.

this patch fixes it, but it seems due to some context changes, it no 
longer applies cleanly against 2.6.8-rc2-mm1.

> Best regards,
> 
> Nicolas

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

