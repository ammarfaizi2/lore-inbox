Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbWGAO7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbWGAO7t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 10:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWGAO71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:59:27 -0400
Received: from mail.gmx.net ([213.165.64.21]:62136 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751878AbWGAO6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:58:02 -0400
X-Authenticated: #428038
Date: Sat, 1 Jul 2006 16:57:55 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       David Luyer <david@luyer.net>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: emergency or init=/bin/sh mode and terminal signals
Message-ID: <20060701145755.GB29190@merlin.emma.line.org>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	David Luyer <david@luyer.net>,
	"linux-os (Dick Johnson)" <linux-os@analogic.com>,
	linux-kernel@vger.kernel.org
References: <20060619220920.GB5788@implementation.residence.ens-lyon.fr> <C0BD782F.CF80%david@luyer.net> <20060620080435.GA4347@implementation.labri.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060620080435.GA4347@implementation.labri.fr>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11-2006-06-08
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006, Samuel Thibault wrote:

> > Also, the above doesn't help people specifying "init=/bin/sh" on the
> > command line (as per the original post subject).  The real solution
> > is for them to specify a different init= or run/exec something to set
> > up their tty and session once logged in.
> 
> Yes. And the problem is that people usually don't know about sessions
> etc, and will just grumble "linux can't work".

Nothing prevents a distributor from providing a proper alternative boot
script to set up the session and launch the shell, and particularly
there is nothing to prevent them from adding a proper boot menu entry
for that rescue system...

-- 
Matthias Andree
