Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272977AbTHPPEi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 11:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272980AbTHPPEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 11:04:38 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:3200 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S272977AbTHPPEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 11:04:35 -0400
Date: Sat, 16 Aug 2003 16:15:40 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200308161515.h7GFFeUS000159@81-2-122-30.bradfords.org.uk>
To: jamie@shareable.org, macro@ds2.pg.gda.pl
Subject: Re: Input issues - key down with no key up
Cc: aebr@win.tue.nl, linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au,
       vojtech@suse.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > The PS/2 keyboard protocol is utterly absurd.
> > > Yep. It's a dozen or more years of hack upon a hack.
> >  Well, mode #3 with no translation in the i8042 looks quite sanely. 
> What are the known problems with mode #3, then?

It's poorly implemented by a lot of keyboards.

Has anybody actually verified that the keyboards that are presenting
the problem in quesiton are not specifically identifyable by their ID
string, or some other means - E.G. they only exist on specific, known
laptops?

My keyboard has a distinct ID, and works fine in set 3, but isn't
detected as set 3 capable.  I'll have to make a patch some time...

John
