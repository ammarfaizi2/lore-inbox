Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030325AbWCTVXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbWCTVXm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 16:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbWCTVXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 16:23:42 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:34792 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030325AbWCTVXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 16:23:41 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Announcing crypto suspend
Date: Mon, 20 Mar 2006 22:22:13 +0100
User-Agent: KMail/1.9.1
Cc: Alon Bar-Lev <alon.barlev@gmail.com>,
       Peter Wainwright <prw@ceiriog.eclipse.co.uk>,
       kernel list <linux-kernel@vger.kernel.org>
References: <20060320080439.GA4653@elf.ucw.cz> <200603202126.23861.rjw@sisk.pl> <20060320203507.GF24523@elf.ucw.cz>
In-Reply-To: <20060320203507.GF24523@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603202222.14634.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 March 2006 21:35, Pavel Machek wrote:
> On Po 20-03-06 21:26:23, Rafael J. Wysocki wrote:
> > On Monday 20 March 2006 20:11, Alon Bar-Lev wrote:
> > > Rafael J. Wysocki wrote:
> > > > and please read the HOWTO.  Unfortunately the RSA-related part hasn't been
> > > > documented yet, but it's pretty straightforward.
> > > 
> > > Hello,
> > > 
> > > I don't understand why you are working so hard on this... If
> > > you want encryption, you should care about all of your data!
> > 
> > I hope you realize there may be sensitive data in the suspend image
> > that are not stored in filesystems (eg. crypto keys, passwords etc.).
> 
> If you have your swap partition on encrypted filesystem, that may
> actually work okay.

Yes, but that's why you may want to encrypt suspend images even if you
don't need to encrypt your filesystems. :-)

Rafael
