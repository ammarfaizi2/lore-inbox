Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbTJSRvM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 13:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbTJSRvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 13:51:12 -0400
Received: from mcomail04.maxtor.com ([134.6.76.13]:30983 "EHLO
	mcomail04.maxtor.com") by vger.kernel.org with ESMTP
	id S262018AbTJSRvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 13:51:06 -0400
Message-ID: <785F348679A4D5119A0C009027DE33C105CDB303@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@Maxtor.com>
To: "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>
Cc: "''Norman Diamond ' '" <ndiamond@wta.att.ne.jp>,
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
Subject: RE: Blockbusting news, results are in
Date: Sun, 19 Oct 2003 11:51:05 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

-----Original Message-----
From: Rogier Wolff

> Know your maxtor drives: Maxtor has been shipping 4-platter,
> 8 head drives for quite a long time. Only recently am I
> starting to see the largest maxtor-drive from a family having
> the space to carry 4 platters, but none of the expected
> capacity are shipping (*).... Care to explain?

I do know our product line.  All of our current 4-platter products are 5400
RPM, and have been for 4 years.  People aren't interested in 5400RPM drives
anymore, and the design tolerances on a 4-platter 7200RPM drive are tight
enough that it becomes extremely difficult to manufacture.

The volume on our only current 4-platter drive is quite small, compared to
the rest of our products.  Most of the industry is getting away from the
HUGE drives and saying that 7200RPM "very big" is more important than the
extra 50GB of capacity.  (300 vs 250)

> Eric, do you know why maxtor stopped putting the number of heads
> in the model number? (It's the last number in the model number,
> just after the letter. Currently all drives set this to "0"). It
> was quite convenient for us to know what to expect from a 92720U8,
> 98196H8, 96147H8 and 4G160J8. (Hmmm apparently, we're mostly
> buying the "largest of the family" drives: they all have 8
> heads! I just looked at the models in some of our computers.)

You're buying 5400RPM products not 7200RPM.  Your 4G160J8 drive was
manufacturered over 2 years ago, it isn't a current product.

I'd guess that the reason we don't put the head number on the drive is to
not confuse OEM databases.  Our drives basically tell us at the end of
manufacturing how big they were able to become, regardless of head count.
To make it easier, our model number is now a capacity instead of a head
count.

It prevents Dell from saying "this model number comes in 4 sizes, we want
different part numbers for each capacity too!" so now we only give them the
capacity.

If you're looking for the densest drives our factory produces (which have,
by definition, the best sequential I/O performance), you can  buy only the
model number of a capacity that is at the peak (e.g. a 250GB drive can't be
made with a 30GB head, while a 200GB can) of a generation.

I think there are other ways to figure out how many heads are physically in
a drive, but I don't want to spoil it and take all the fun away.

--eric
