Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262224AbTCRIPJ>; Tue, 18 Mar 2003 03:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262228AbTCRIPI>; Tue, 18 Mar 2003 03:15:08 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:45583 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262224AbTCRIPG>; Tue, 18 Mar 2003 03:15:06 -0500
Date: Tue, 18 Mar 2003 09:26:01 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Patch: Fix BUGging in ide-disk.c
Message-ID: <20030318082601.GE10472@atrey.karlin.mff.cuni.cz>
References: <1047939287.5426.5.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047939287.5426.5.camel@laptop-linux.cunninghams>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch fixes a problem with the suspend/resume code in ide-disk.c
> which is triggered when the code is called multiple times for a drive.
> When the second resume call was made, the BUG was activated.
> 
> Please apply if something hasn't already been done about this.

Yes, this looks good.
								Pavel

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
