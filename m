Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263399AbTJZSjW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 13:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263400AbTJZSjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 13:39:21 -0500
Received: from mcomail04.maxtor.com ([134.6.76.13]:14602 "EHLO
	mcomail04.maxtor.com") by vger.kernel.org with ESMTP
	id S263399AbTJZSjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 13:39:20 -0500
Message-ID: <785F348679A4D5119A0C009027DE33C105CDB39C@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@Maxtor.com>
To: "'Norman Diamond'" <ndiamond@wta.att.ne.jp>,
       "'Hans Reiser '" <reiser@namesys.com>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       "'John Bradford '" <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       nikita@namesys.com, "'Pavel Machek '" <pavel@ucw.cz>,
       "'Justin Cormack '" <justin@street-vision.com>,
       "'Russell King '" <rmk+lkml@arm.linux.org.uk>,
       "'Vitaly Fertman '" <vitaly@namesys.com>,
       "'Krzysztof Halasa '" <khc@pm.waw.pl>
Subject: RE: Blockbusting news, results end
Date: Sun, 26 Oct 2003 11:39:21 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Norman Diamond [mailto:ndiamond@wta.att.ne.jp]
>
> The drive finally reallocated the block and there are no 
> longer any visible
> bad blocks.

If a drive wants to reallocate a block, but due to some temporary condition
is unable to (vibration, excessive temperature, etc), odds are there's no
way for that drive to "remember" that it needs to reassign that block, so if
you reboot the drive or reset it or whatever, you're back at square 1.

The only "memory" that survives between power cycles in a disk drive is on
the media, so if we can't reliably access the media we're hosed.

--eric

