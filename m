Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbVI1Qmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbVI1Qmr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 12:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbVI1Qmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 12:42:46 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:7688 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751423AbVI1Qmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 12:42:46 -0400
Date: Wed, 28 Sep 2005 18:42:37 +0200
From: Olivier Galibert <galibert@pobox.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Re: Infinite interrupt loop, INTSTAT = 0
Message-ID: <20050928164237.GA40806@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>,
	"Hack inc." <linux-kernel@vger.kernel.org>
References: <20050928134514.GA19734@dspnet.fr.eu.org> <1127919909.4852.7.camel@mulgrave> <20050928160744.GA37975@dspnet.fr.eu.org> <1127924686.4852.11.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127924686.4852.11.camel@mulgrave>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2005 at 11:24:46AM -0500, James Bottomley wrote:
> On Wed, 2005-09-28 at 18:07 +0200, Olivier Galibert wrote:
> > scsi1:0:0:0: Attempting to abort cmd ffff8101b1cdf880: 0x28 0x0 0x0
> > 0xbc 0x0 0x3f 0x0 0x0 0x8 0x0
> 
> Hmm, that message doesn't appear in the current kernel driver.
> 
> Is this a non-standard kernel or non-standard aic79xx driver?

Hmmm, indeed, a leftover from when I was trying to debug some things
(a message in ahd_linux_abort).  Lemme recompile a perfectly vanilla
2.6.13.2.

  OG.
