Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422876AbWBOAnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422876AbWBOAnZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 19:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422902AbWBOAnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 19:43:25 -0500
Received: from mail.gmx.net ([213.165.64.21]:27052 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422876AbWBOAnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 19:43:25 -0500
X-Authenticated: #428038
Date: Wed, 15 Feb 2006 01:43:20 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Greg KH <greg@kroah.com>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060215004320.GB21742@merlin.emma.line.org>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20060125181847.b8ca4ceb.grundig@teleline.es> <20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de> <878xt3rfjc.fsf@amaterasu.srvr.nix> <43ED005F.5060804@tmr.com> <20060210235654.GA22512@kroah.com> <43F0891E.nailKUSCGC52G@burner> <871wy6sy7y.fsf@hades.wkstn.nix> <43F1BE96.nailMY212M61V@burner> <20060214223001.GB357@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060214223001.GB357@kroah.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2006, Greg KH wrote:

> On Tue, Feb 14, 2006 at 12:27:18PM +0100, Joerg Schilling wrote:
> > 
> > Please send me the whitepaper that was used to define the interfaces
> > and functionality of the /sys device
> 
> I was not aware that there is now a rule that we must write whitepapers
> describing as to what the interface looks like in complete detail that
> we want to add to the Linux kernel.  Will you please point me to the
> proper authorities that will be enforcing this newly created rule?

Well, Jörg's questions, although ridiculously exaggerated and quixotic,
show a general problem in Linux: documentation is constantly outdated,
missing, and not part of the kernel package.

If Linux were based in Utopia, it would ship with a complete set of
kernel-related manual pages and HOWTOs.

I appreciate the efforts of the old and new man-pages maintainers, and I
know the problems in motivation when writing documentation and keeping
it up to date distracts people from writing code -- but those people
know their code best.

> > Please send me the other documentation (e.g. man pages) on the /sys
> > device
> 
> What "/sys device"?  sysfs is a file system, and there have been many
> magazine articles, and conference papers written, and talks given on the
> topic.

And that is the key problem. magazine here, conference there, talk
(perhaps only slides available) somewhere else -- a manual that was in
/usr/src/linux/Documentation might make a real difference. Even a
commented link list in Documentation/* might be a good starting point.

Patrick Mochel added some bits three years ago, but they were internals
and thus a bit less interesting.

-- 
Matthias Andree
