Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbTDHVp1 (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 17:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbTDHVp1 (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 17:45:27 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:2066 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261804AbTDHVp0 (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 17:45:26 -0400
Date: Tue, 8 Apr 2003 23:57:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Pavel Machek <pavel@ucw.cz>, Jes Sorensen <jes@wildopensource.com>,
       Martin Hicks <mort@bork.org>, linux-kernel@vger.kernel.org,
       wildos@sgi.com
Subject: Re: [patch] printk subsystems
Message-ID: <20030408215703.GA1538@atrey.karlin.mff.cuni.cz>
References: <20030407201337.GE28468@bork.org> <20030408184109.GA226@elf.ucw.cz> <m3k7e4ycys.fsf@trained-monkey.org> <20030408210251.GA30588@atrey.karlin.mff.cuni.cz> <3E933AB2.8020306@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E933AB2.8020306@zytor.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, I think we should first kill all crappy messages -- that
> > benefits everyone. I believe that if we kill all unneccessary
> > (carrying no information  except perhaps copyright or advertising)
> > will help current problem a lot.
> > 
> 
> That may sometimes be true, but a few things may be useful to be able to
> turn back on.

Well, #define DEBUG in the driver seems like the way to go. I do not
like "subsystem ID" idea, because subsystems are not really well
defined etc.
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
