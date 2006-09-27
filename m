Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWI0Lkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWI0Lkp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 07:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030186AbWI0Lkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 07:40:45 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:49128 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030185AbWI0Lkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 07:40:45 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [GIT PATCH] Driver Core patches for 2.6.18
Date: Wed, 27 Sep 2006 13:42:56 +0200
User-Agent: KMail/1.9.1
Cc: Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Dave Jones <davej@redhat.com>
References: <20060926053728.GA8970@kroah.com> <1159354112.6374.3.camel@Homer.simpson.net> <1159362206.6417.34.camel@Homer.simpson.net>
In-Reply-To: <1159362206.6417.34.camel@Homer.simpson.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609271342.57083.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 27 September 2006 15:03, Mike Galbraith wrote:
> On Wed, 2006-09-27 at 10:48 +0000, Mike Galbraith wrote:
> > On Wed, 2006-09-27 at 08:58 +0200, Rafael J. Wysocki wrote:
> > 
> > > Please try to remove the acpi_cpufreq driver before the suspend.
> > 
> > Yeah, that's what's causing the suspend failure.  Thanks.
> 
> Followup:
> 
> Without the P-States driver (CONFIG_X86_ACPI_CPUFREQ) enabled, both
> virgin 2.6.18 and 2.6.18 with this patchset suspend/resume just fine,
> and cpufreq (p4_clockmod) works fine.
> 
> Why CONFIG_X86_ACPI_CPUFREQ blows my box out of the water with the
> patchset applied, I have no idea.

I think DaveJ is looking into it.

> Enabling suspend tracing didn't do 
> anything for me except cause fsck to check my drive, me to reset my
> clock, only to have fsck then check my drive yet again :)

Well, I've never used it. ;-)

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
