Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTJSTul (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 15:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTJSTuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 15:50:40 -0400
Received: from gprs149-131.eurotel.cz ([160.218.149.131]:897 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262115AbTJSTug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 15:50:36 -0400
Date: Sun, 19 Oct 2003 21:49:33 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Hans Reiser <reiser@namesys.com>
Cc: Larry McVoy <lm@bitmover.com>, Norman Diamond <ndiamond@wta.att.ne.jp>,
       Wes Janzen <superchkn@sbcglobal.net>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       nikita@namesys.com, Pavel Machek <pavel@ucw.cz>,
       Justin Cormack <justin@street-vision.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Vitaly Fertman <vitaly@namesys.com>, Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: Blockbusting news, results are in
Message-ID: <20031019194933.GB354@elf.ucw.cz>
References: <1c6401c395e7$16630d00$3eee4ca5@DIAMONDLX60> <20031019041553.GA25372@work.bitmover.com> <3F924660.4040405@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F924660.4040405@namesys.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >I've told you guys over and over that you need to CRC the data in user
> >space, we do that in our backup scripts and it tells us when the drives
> >are going bad.  S
> >
> Why do the CRC in user space, that requires modifying every one of 7000+ 
> applications (if I understand you correctly, which is far from a sure 
> thing;-) )?
> 
> Write a reiser4 CRC file plugin.  It would take a weekend, and most of the 
> work would be cut and pasting from the default file plugin..  

Even better, use crc loop method, and do checks at block device
level. I had patch to implement that...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
