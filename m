Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263201AbTE3BAs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 21:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263206AbTE3BAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 21:00:48 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:64412
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S263201AbTE3BAr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 21:00:47 -0400
Date: Thu, 29 May 2003 21:14:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [BK PATCH] e100 fix
Message-ID: <20030530011406.GA23398@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.5

Others can grab the patch from

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.5/2.5.70-bk3-netdrvr2.patch.gz

This will update the following files:

 drivers/net/e100/e100_main.c |   76 ++++++++++++++++++++++---------------------
 1 files changed, 39 insertions(+), 37 deletions(-)

through these ChangeSets:

<scott.feldman@intel.com> (03/05/29 1.1259)
   [netdrvr e100] move register_netdev below netdev struct init
   
   (i.e. the better fix)

<jgarzik@redhat.com> (03/05/29 1.1229.17.12)
   Cset exclude: shemminger@osdl.org|ChangeSet|20030529205634|46794
   
   The needed fix winds up breaking SG, checksumming, and other stuff
   in the process.

