Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264392AbUEIVuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264392AbUEIVuG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 17:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264397AbUEIVuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 17:50:05 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43489 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264392AbUEIVuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 17:50:00 -0400
Date: Sun, 9 May 2004 23:49:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uspend to Disk - Kernel 2.6.4 vs. r50p
Message-ID: <20040509214959.GD13603@atrey.karlin.mff.cuni.cz>
References: <20040429064115.9A8E814D@damned.travellingkiwi.com> <200405042018.23043.rob@landley.net> <20040508225401.GF29255@atrey.karlin.mff.cuni.cz> <200405082331.30669.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405082331.30669.rob@landley.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > If you suspend, mount
> > your filesytems, do some work and then resume, you are probably going
> > to do some pretty nasty corruption. Just don't do that.
> >
> > But this problem is shared by swsusp, swsusp2 *and* pmdisk.
> 
> I know.  I also know that ext2 (and derivatives) have both "last mounted" and 
> "last written to" datestamp fields (other filesystems probably do as well, 
> but I don't use 'em) and it would be really nice to check those as matching 
> what they were when you suspended, and abort the resume if they don't 
> match...

Well, feel free to code that, that will allow us to kill few
warnings... Or rather tone them down. It is still "dont do that"
situation.

> > > Sigh.  I _really_ don't have time for this right now.  I wonder if it
> > > would be possible to just send Patrick some money?
> >
> > He's out of time, so money is not likely to help. Sending some money
> > to Nigel might do the trick ;-).
> 
> His code isn't the one I've gotten to work yet... :)

2.4 version should be rather easy to get going...
									Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
