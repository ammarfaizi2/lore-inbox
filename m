Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbWBPFrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbWBPFrA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 00:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWBPFrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 00:47:00 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:34686 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932490AbWBPFq7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 00:46:59 -0500
Date: Thu, 16 Feb 2006 06:46:44 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: carsteno@de.ibm.com, cotte@de.ibm.com, hch@lst.de, horst.hummel@de.ibm.com,
       linux-kernel@vger.kernel.org, heicars2@de.ibm.com, wein@de.ibm.com,
       mschwid2@de.ibm.com, ihno@suse.de
Subject: Re: [PATCH 0/5] new dasd ioctl patchkit
Message-ID: <20060216054644.GA9241@osiris.boeblingen.de.ibm.com>
References: <1139935988.6183.5.camel@localhost.localdomain> <20060214190909.GA20527@lst.de> <43F3397B.3090207@de.ibm.com> <20060215120343.1e4e8afe.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060215120343.1e4e8afe.akpm@osdl.org>
User-Agent: mutt-ng/devel-r781 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > As long as we backout the bogus eer
> > > patch before 2.6.16 all the cleanups and even the eckd ioctl fix
> > > can wait.  But don't put this crappy interface into 1.6.16 and thus
> > > SLES10 so that applications start to rely on it.
> > ACK: Given that a) both Horst and Christoph think the ioctl interface
> > needs cleanup but proposed cleanup interfers with existing
> > functionality (cmb), and b) later cleanup would change the
> > user-interface of eer, we should rush neither the ioctl change nor
> > eer into .16 until the maintainer is back afaics.
> > 
> 
> I don't have a patch in hand to purely back out the eer modeule.  What I
> have is
> 
> dasd-cleanup-dasd_ioctl.patch
> dasd-cleanup-dasd_ioctl-fix.patch
> dasd-add-per-disciple-ioctl-method.patch
> dasd-merge-dasd_cmd-into-dasd_mod.patch
> dasd-backout-dasd_eer-module.patch
> dasd-kill-dynamic-ioctl-registration.patch
> 
> So what do we do?

Looks like people still haven't agreed. If they _finally_ agree on something
and the result is that the eer should be backed out, I will send that patch.
Sorry... I'm just the stupid patch monkey here.

Heiko
