Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWF2SOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWF2SOk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 14:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWF2SOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 14:14:40 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:19072 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751238AbWF2SOi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 14:14:38 -0400
Date: Thu, 29 Jun 2006 11:12:16 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Michael Tokarev <mjt@tls.msk.ru>, Chris Wright <chrisw@sous-sol.org>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Andrey Borzenkov <arvidjaar@mail.ru>,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris@amavis.tls.msk.ru, Wedgwood@vger.kernel.org
Subject: Re: [PATCH 07/13] SERIAL: PARPORT_SERIAL should depend on SERIAL_8250_PCI
Message-ID: <20060629181216.GY11588@sequoia.sous-sol.org>
References: <20060620114527.934114000@sous-sol.org> <20060620114733.957367000@sous-sol.org> <44A40E68.9080906@tls.msk.ru> <20060629173710.GE9709@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060629173710.GE9709@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Russell King (rmk+lkml@arm.linux.org.uk) wrote:
> On Thu, Jun 29, 2006 at 09:31:20PM +0400, Michael Tokarev wrote:
> > I've no idea how this patch slipped into 2.6.16 -stable queue in the
> > first place... ;)

When Russell sent the patch to stable he said "For the stable branches"
which I took to mean both 2.6.16 and 2.6.17, so I added to both.

> Probably because I didn't pay enough attention to the review mails.
> I wasn't expecting it to go into 2.6.16, so thought little of it.

I'll add a revert patch for 2.6.16.  Sound OK?
-chris
