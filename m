Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030332AbVIATy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332AbVIATy7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 15:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbVIATy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 15:54:58 -0400
Received: from sd291.sivit.org ([194.146.225.122]:526 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S1030332AbVIATy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 15:54:58 -0400
Subject: Re: 2.6.13-rc7-git2 crashes on iBook
From: Stelian Pop <stelian@popies.net>
To: Daniel Drake <dsd@gentoo.org>
Cc: Alex Williamson <alex.williamson@hp.com>, Andreas Schwab <schwab@suse.de>,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <431755E4.70703@gentoo.org>
References: <jehdda2tqt.fsf@sykes.suse.de>
	 <1125288175.5595.3.camel@localhost.localdomain>
	 <1125311951.4662.3.camel@localhost.localdomain> <431755E4.70703@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-15
Date: Thu, 01 Sep 2005 21:54:54 +0200
Message-Id: <1125604494.3999.7.camel@deep-space-9.dsnet>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 01 septembre 2005 à 20:26 +0100, Daniel Drake a écrit :
> Hi,
> 
> Stelian Pop wrote:
> > Confirmed on an Apple Powerbook too.
> > 
> > For reference, the (already reverted) patch which needs to be applied is
> > below.
> > 
> > Signed-off-by: Stelian Pop <stelian@popies.net>
> > 
> > Index: linux-2.6.git/drivers/pci/setup-res.c
[...]

> Sorry for my ignorance. Which tree was this reverted in? You are probably 
> aware that this bug made it into 2.6.13 (patch was not reverted there).

It must be my bad english but I wasn't implying that the patch was
reverted in 2.6.13 but that one should apply it (just apply, without -R,
because I didn't attach the original patch but a reversed version of it)
on a clean 2.6.13 tree in order to make it work. :)

However, a different fix (a real fix, not the workaround proposed above)
was discussed on lkml this week and BenH proposed a patch I haven't had
the chance to test yet (see http://lkml.org/lkml/2005/8/31/1 ).

Stelian.
-- 
Stelian Pop <stelian@popies.net>

