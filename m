Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbVKQVQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbVKQVQR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 16:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbVKQVQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 16:16:17 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:36574 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750937AbVKQVQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 16:16:16 -0500
Subject: Re: [linux-pm] [RFC] userland swsusp
From: Lee Revell <rlrevell@joe-job.com>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: Dave Jones <davej@redhat.com>, Olivier Galibert <galibert@pobox.com>,
       linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <E1Ecr0F-0003TC-00@chiark.greenend.org.uk>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com>
	 <20051116164429.GA5630@kroah.com> <1132172445.25230.73.camel@localhost>
	 <20051116220500.GF12505@elf.ucw.cz>
	 <20051117170202.GB10402@dspnet.fr.eu.org>
	 <1132257432.4438.8.camel@mindpipe>
	 <20051117201204.GA32376@dspnet.fr.eu.org>
	 <1132258855.4438.11.camel@mindpipe> <1132258855.4438.11.camel@mindpipe>
	 <20051117203731.GG5772@redhat.com>
	 <E1Ecr0F-0003TC-00@chiark.greenend.org.uk>
Content-Type: text/plain
Date: Thu, 17 Nov 2005 16:16:07 -0500
Message-Id: <1132262168.5959.24.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-17 at 21:09 +0000, Matthew Garrett wrote:
> Dave Jones <davej@redhat.com> wrote:
> 
> > I don't know about other distros, but here's how that usually goes for Fedora users..
> 
> It Works in Ubuntu(TM)[0]. More seriously: recent alsa-libs should
> provide a pile of stuff in /usr/share/alsa/cards which switches dmix on
> by default in most cards[1]. Obviously, for this to work usefully, your
> application needs to be using libalsa (either natively or using the aoss
> wrapper).
> 
> [0] The only patch is to enable symbol versioning
> [1] Not ones with hardware mixing

[1] is already done for most of the hardware that needs it.  No user
configuration at all should be required.  Please, let us know if you
find a device it does not work that way for.

Lee

