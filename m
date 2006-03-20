Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbWCTUf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbWCTUf2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 15:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbWCTUf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 15:35:28 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30638 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030241AbWCTUf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 15:35:28 -0500
Date: Mon, 20 Mar 2006 21:35:07 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alon Bar-Lev <alon.barlev@gmail.com>,
       Peter Wainwright <prw@ceiriog.eclipse.co.uk>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Announcing crypto suspend
Message-ID: <20060320203507.GF24523@elf.ucw.cz>
References: <20060320080439.GA4653@elf.ucw.cz> <200603201954.45572.rjw@sisk.pl> <441EFE54.2090004@gmail.com> <200603202126.23861.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603202126.23861.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 20-03-06 21:26:23, Rafael J. Wysocki wrote:
> Hi,
> 
> On Monday 20 March 2006 20:11, Alon Bar-Lev wrote:
> > Rafael J. Wysocki wrote:
> > > and please read the HOWTO.  Unfortunately the RSA-related part hasn't been
> > > documented yet, but it's pretty straightforward.
> > 
> > Hello,
> > 
> > I don't understand why you are working so hard on this... If
> > you want encryption, you should care about all of your data!
> 
> I hope you realize there may be sensitive data in the suspend image
> that are not stored in filesystems (eg. crypto keys, passwords etc.).

If you have your swap partition on encrypted filesystem, that may
actually work okay.

OTOH uswsusp _destroys_ data after resume. Even if you are forced to
reveal your passphrase later, it should not be possible to recover
data from swsusp image.
								Pavel
-- 
Picture of sleeping (Linux) penguin wanted...
