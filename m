Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273403AbTG3Tjk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 15:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273405AbTG3Tjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 15:39:40 -0400
Received: from CPE-65-29-19-166.mn.rr.com ([65.29.19.166]:60296 "EHLO
	www.enodev.com") by vger.kernel.org with ESMTP id S273403AbTG3Tjj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 15:39:39 -0400
Subject: Re: Buffer I/O error on device hde3, logical block 4429
From: Shawn <core@enodev.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <200307302125.27898.m.c.p@wolk-project.de>
References: <1059585712.11341.24.camel@localhost>
	 <1059592520.11341.47.camel@localhost>
	 <200307302125.27898.m.c.p@wolk-project.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059593977.11341.57.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 30 Jul 2003 14:39:38 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, my fstab entry seems pretty default

/dev/hde3	/hdg/3	reiserfs	defaults	1 2

On Wed, 2003-07-30 at 14:25, Marc-Christian Petersen wrote:
> On Wednesday 30 July 2003 21:15, Shawn wrote:
> 
> Hi,
> 
> > It appears Mike Galbraith has seen something similar in -vanilla.
> > http://www.ussg.iu.edu/hypermail/linux/kernel/0307.3/1987.html
> > Does anyone have any interest at all in pursuing this? Hopefully? I'm
> > glad to try and be the pig of Guinea. Kill piggy!
> 
> > > I am running 2.6.0-test2-mm1, and upon boot have received a gift of many
> > > "Buffer I/O error on device hde3" messages in my log. After they quit,
> > > they never seem to come back.
> hmm, I had the same errors yesterday and the culprit was a "data=writeback" 
> for a reiserfs partition. 2.6 don't know about data= for reiserfs.
> 
> Could it be your problem too?
> 
> ciao, Marc
> 
