Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbTJZJjI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 04:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbTJZJjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 04:39:08 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:4736 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262655AbTJZJjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 04:39:06 -0500
Date: Sun, 26 Oct 2003 10:39:49 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200310261039.h9QAdniV000310@81-2-122-30.bradfords.org.uk>
To: "Norman Diamond" <ndiamond@wta.att.ne.jp>,
       "Mudama, Eric" <eric_mudama@Maxtor.com>,
       "'Hans Reiser '" <reiser@namesys.com>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       <linux-kernel@vger.kernel.org>, <nikita@namesys.com>,
       "'Pavel Machek '" <pavel@ucw.cz>,
       "'Justin Cormack '" <justin@street-vision.com>,
       "'Russell King '" <rmk+lkml@arm.linux.org.uk>,
       "'Vitaly Fertman '" <vitaly@namesys.com>,
       "'Krzysztof Halasa '" <khc@pm.waw.pl>
In-Reply-To: <334101c39b94$268a0370$24ee4ca5@DIAMONDLX60>
References: <334101c39b94$268a0370$24ee4ca5@DIAMONDLX60>
Subject: Re: Blockbusting news, results get worse
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 4.  When writing ZEROES to the bad sector, the drive reports SUCCESS.
> But it lies.  Subsequent attempts to read still fail.  Subsequent writing of
> zeroes appears to succeed again.  Subsequent attempts to read still fail.

> I still have to say, we can't fix Toshiba, and we can avoid Toshiba, but
> meanwhile we can fix Linux.

How do you suggest we 'fix' 4, above, other than to flush the cache
and verify each time a full sector of zeros is written to the disk?

John.
