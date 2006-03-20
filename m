Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbWCTVfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbWCTVfG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 16:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbWCTVfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 16:35:05 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30374 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964950AbWCTVfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 16:35:01 -0500
Date: Mon, 20 Mar 2006 22:34:00 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alon Bar-Lev <alon.barlev@gmail.com>,
       Peter Wainwright <prw@ceiriog.eclipse.co.uk>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Announcing crypto suspend
Message-ID: <20060320213400.GI24523@elf.ucw.cz>
References: <20060320080439.GA4653@elf.ucw.cz> <200603202126.23861.rjw@sisk.pl> <20060320203507.GF24523@elf.ucw.cz> <200603202222.14634.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603202222.14634.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 20-03-06 22:22:13, Rafael J. Wysocki wrote:
> On Monday 20 March 2006 21:35, Pavel Machek wrote:
> > On Po 20-03-06 21:26:23, Rafael J. Wysocki wrote:
> > > On Monday 20 March 2006 20:11, Alon Bar-Lev wrote:
> > > > Rafael J. Wysocki wrote:
> > > > > and please read the HOWTO.  Unfortunately the RSA-related part hasn't been
> > > > > documented yet, but it's pretty straightforward.
> > > > 
> > > > Hello,
> > > > 
> > > > I don't understand why you are working so hard on this... If
> > > > you want encryption, you should care about all of your data!
> > > 
> > > I hope you realize there may be sensitive data in the suspend image
> > > that are not stored in filesystems (eg. crypto keys, passwords etc.).
> > 
> > If you have your swap partition on encrypted filesystem, that may
> > actually work okay.
> 
> Yes, but that's why you may want to encrypt suspend images even if you
> don't need to encrypt your filesystems. :-)

Of course, agreed. Encrypting filesystem is stupid thing from
data-recovery standpoint; and I care about my data; it is also hard to
backup. For some uses it is of course neccessary, but it has lots of
disadvantages, too.

Encrypted swsusp has basically no disadvantages.

[I believe we should encrypt swap with random key generated on boot by
default. That should be also very cheap, and has no real
disadvantages].
								Pavel
-- 
Picture of sleeping (Linux) penguin wanted...
