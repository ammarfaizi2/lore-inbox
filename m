Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264190AbTH1SsH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 14:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264189AbTH1Sr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 14:47:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41453 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264187AbTH1Srw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 14:47:52 -0400
Date: Thu, 28 Aug 2003 11:18:33 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Micha Feigin <michf@post.tau.ac.il>
Cc: Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: suspend fails under load
Message-ID: <20030828091832.GC819@openzaurus.ucw.cz>
References: <1060178056.1390.4.camel@litshi.luna.local> <20030808135037.GE6914@openzaurus.ucw.cz> <1060686223.3777.1.camel@litshi.luna.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060686223.3777.1.camel@litshi.luna.local>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Under kernel 2.6.0-test2 I get the behaviour that when trying to suspend
> > > under load, I get all the way to the black screen, after which I am
> > > supposed to see the writing pages to disk message.
> > > Instead I see an error message flashing by to fast to read and
> > 
> > that's easy: add mdelays to suspend.c :-)
> 
> Would like to, but couldn't tell where the message was coming from so
> that I can put it in the right location ;)
> If I could read the message then I would be able to know what to grep
> for, kind of the chicken and the egg.

So add mdelays to all messages.
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

