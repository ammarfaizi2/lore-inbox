Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268420AbUGXKir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268420AbUGXKir (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 06:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268421AbUGXKir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 06:38:47 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:7633 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268420AbUGXKip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 06:38:45 -0400
Date: Sat, 24 Jul 2004 12:38:35 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: hpa@zytor.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: A users thoughts on the new dev. model
Message-ID: <20040724103835.GT19329@fs.tum.de>
References: <40FFD760.8060504@unix.eng.ua.edu> <cdpee5$otu$1@gatekeeper.tmr.com> <cdr5i3$568$1@terminus.zytor.com> <20040723214055.GR19329@fs.tum.de> <32791.66.11.168.47.1090623872.squirrel@www.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32791.66.11.168.47.1090623872.squirrel@www.zytor.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2004 at 04:04:32PM -0700, hpa@zytor.com wrote:
> >
> > One problem from a user's point of view is that removal of obsolete code
> > that works sufficiently for some users.
> >
> > Andrew said explicitely in a mail to linux-kernel that he'd consider
> > removing devfs "mid-2005" - and it didn't sound as if this would only be
> > a -mm "feature".
> >
> > Even if 2.7 is started this doesn't has to imply that it has to be
> > flooded with big changes - a short 2.7 with relativley few invasive
> > changes might also be an option.
> >
> 
> There is no difference from a user's point of view between a "short 2.7"
> and "a close -mm tree."  Either way devfs is on death row, because it's

You missed one important difference:

With a "short 2.7", 2.6 stays unchanged. This way, users have a 2.6 tree 
which will continue to stay unchanged regarding such user-visible 
changes but still gets lots of fixes for several years.

For many users I know it's an important difference whether upgrading 
from 2.6.X to 2.6.Y (with Y > X) has a low risk of breaking anything 
working with 2.6.X or not.

Many people complained after USB_SCANNER was removed in 2.6.3, and the 
only excuse (besides that it had several bugs and was for most users  
inferior to SANE) is that this was very early in the 2.6 series.

> buggy and unmaintained.  Any piece of code, *especially* one as invasive
> as devfs, which is buggy and unmaintained is a hassle to for *all* kernel
> development, and have to be extricated at some point.

I don't disagree with this statement. But IMHO "some point" shouldn't 
be in 2.6 .

> 	-hpa

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

