Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263447AbTJ0RnL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 12:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTJ0RnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 12:43:10 -0500
Received: from mcomail04.maxtor.com ([134.6.76.13]:53258 "EHLO
	mcomail04.maxtor.com") by vger.kernel.org with ESMTP
	id S263447AbTJ0RnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 12:43:08 -0500
Message-ID: <785F348679A4D5119A0C009027DE33C105CDB3B0@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@Maxtor.com>
To: "'Norman Diamond'" <ndiamond@wta.att.ne.jp>,
       "'Hans Reiser '" <reiser@namesys.com>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       "'John Bradford '" <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       nikita@namesys.com, "'Pavel Machek '" <pavel@ucw.cz>,
       "'Justin Cormack '" <justin@street-vision.com>,
       "'Vitaly Fertman '" <vitaly@namesys.com>,
       "'Krzysztof Halasa '" <khc@pm.waw.pl>
Subject: RE: Blockbusting news, results get worse
Date: Mon, 27 Oct 2003 10:43:07 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> Yeah, I need to deliberately damage one block in order to 
> test the firmware, but I don't want to damage multiple
> blocks and use up the reallocation space.  I am a home
> user, even if I also do programming at work, even if I
> also volunteer one day each weekend to test Linux.  How can I 
> arrange to damage one block on a disk?

Um... you can do that by shorting various pins on the PCBA if you have
access to an oscilloscope, or put it under heavy write workload and remove
power.

A modern drive has many thousands of reassign sectors available, so I don't
think either of these events will cause a permanent issue.

I'd also suggest reading older ATA specs, since some vendors still support
older commands that were capable of various wierdness that might be useful.

--eric

