Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262404AbTJTGWj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 02:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262405AbTJTGWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 02:22:38 -0400
Received: from users.linvision.com ([62.58.92.114]:26535 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262404AbTJTGWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 02:22:36 -0400
Date: Mon, 20 Oct 2003 08:22:33 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: "Mudama, Eric" <eric_mudama@Maxtor.com>
Cc: "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       "''Norman Diamond ' '" <ndiamond@wta.att.ne.jp>,
       "''Hans Reiser ' '" <reiser@namesys.com>,
       "''Wes Janzen ' '" <superchkn@sbcglobal.net>,
       "''John Bradford ' '" <john@grabjohn.com>,
       "''linux-kernel@vger.kernel.org ' '" <linux-kernel@vger.kernel.org>,
       "''nikita@namesys.com ' '" <nikita@namesys.com>,
       "''Pavel Machek ' '" <pavel@ucw.cz>,
       "''Justin Cormack ' '" <justin@street-vision.com>,
       "''Russell King ' '" <rmk+lkml@arm.linux.org.uk>,
       "''Vitaly Fertman ' '" <vitaly@namesys.com>,
       "''Krzysztof Halasa ' '" <khc@pm.waw.pl>
Subject: Re: Blockbusting news, results are in
Message-ID: <20031020062233.GE9280@bitwizard.nl>
References: <785F348679A4D5119A0C009027DE33C105CDB303@mcoexc04.mlm.maxtor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <785F348679A4D5119A0C009027DE33C105CDB303@mcoexc04.mlm.maxtor.com>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 19, 2003 at 11:51:05AM -0600, Mudama, Eric wrote:
>  
> 
> -----Original Message-----
> From: Rogier Wolff
> 
> > Know your maxtor drives: Maxtor has been shipping 4-platter,
> > 8 head drives for quite a long time. Only recently am I
> > starting to see the largest maxtor-drive from a family having
> > the space to carry 4 platters, but none of the expected
> > capacity are shipping (*).... Care to explain?
> 
> I do know our product line.  All of our current 4-platter products are 5400
> RPM, and have been for 4 years.  People aren't interested in 5400RPM drives
> anymore, and the design tolerances on a 4-platter 7200RPM drive are tight
> enough that it becomes extremely difficult to manufacture.

OK. Thanks for the explanation. We'd (apparently) buy them, as
evidenced by the disks I found on a random search for maxtor
drives in my company. (about half are maxtor).

The 160G 5400 RPM drives will do 36 Mbyte per second, the 7200 versions
might do 50Mb per second, the difference is unimportant. 

> It prevents Dell from saying "this model number comes in 4 sizes, we want
> different part numbers for each capacity too!" so now we only give them the
> capacity.

We're getting annoyed at WD because they are selling WD800 drives 
(80G) with 2, 4, 6 and 8 heads(*). So when we order a replacement
WD800 for spare parts for a broken one, we might end up with a
different generation drive which is useless for the "part exchange"
project....

(*) they probably don't sell the full complement... yet.

> If you're looking for the densest drives our factory produces (which have,
> by definition, the best sequential I/O performance), you can  buy only the

You're assuming that a head-switch is faster than a track-to-track seek.
Apparently that is no longer true. We've seen drives that "scan" a whole
platter before switching heads. We've seen drives that do this on a 
per-region basis. 

> model number of a capacity that is at the peak (e.g. a 250GB drive can't be
> made with a 30GB head, while a 200GB can) of a generation.
> 
> I think there are other ways to figure out how many heads are physically in
> a drive, but I don't want to spoil it and take all the fun away.

How about: "Opening it up and having a peek?" :-) That certainly
works. But most vendors don't let me do that before I buy.  :-)

		Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
