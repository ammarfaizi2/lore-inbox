Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161047AbWBTRFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161047AbWBTRFj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 12:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161048AbWBTRFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 12:05:39 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:1285 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1161047AbWBTRFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 12:05:37 -0500
Date: Mon, 20 Feb 2006 18:05:37 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Matthias Hensler <matthias@wspse.de>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
Subject: Re: suspend2 review [was Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)]
Message-ID: <20060220170537.GB33155@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Pavel Machek <pavel@suse.cz>, Nigel Cunningham <nigel@suspend2.net>,
	Matthias Hensler <matthias@wspse.de>,
	Sebastian Kgler <sebas@kde.org>,
	kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602200709.17955.nigel@suspend2.net> <20060219234212.GA1762@elf.ucw.cz> <200602201210.58362.nigel@suspend2.net> <20060220124937.GB16165@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220124937.GB16165@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 01:49:37PM +0100, Pavel Machek wrote:
> > > Yep, if you do it all in userspace, this vanishes. 340 lines down.
> > 
> > And you gain? Let's try not to be too biased :).
> 
> I gain 340 less lines to review. For me to review, for akpm to review,
> and for Linus to review. That's important.

Pavel, if you mean that the userspace code will not be reviewed to
standards the kernel code is, kill uswsusp _NOW_ before it does too
much damage.  Unreliable suspend eats filesystems for breakfast.  The
other userspace components of the kernels services are either optional
(udev) or not that important (alsa).

  OG.
