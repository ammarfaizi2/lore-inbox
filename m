Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272066AbTGYN2d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 09:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272067AbTGYN2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 09:28:33 -0400
Received: from fmr03.intel.com ([143.183.121.5]:46796 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S272066AbTGYN2a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 09:28:30 -0400
Message-ID: <E5DA6395B8F9614EB7A784D628184B200D9936@hdsmsx402.hd.intel.com>
From: "Cress, Andrew R" <andrew.r.cress@intel.com>
To: "'Tugrul Galatali'" <tugrul@galatali.com>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.6.0-test1 Adaptec aic7899 Ultra160 SCSI grief
Date: Fri, 25 Jul 2003 06:43:36 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tugrul,

If it is a firmware problem, the firmware is upgradable, but you have to get
the firmware from IBM rather than Seagate.  IBM has special firmware for
their ST (Seagate) OEM'd disks.

You can use the IBM utility (runs from a CD in DOS), or the sgdskfl utility
under Linux from scsirastools.sf.net.

But do verify the SCSI cabling/termination first.

Andy

-----Original Message-----
From: Tugrul Galatali [mailto:tugrul@galatali.com] 
Sent: Thursday, July 24, 2003 9:02 PM
To: Justin T. Gibbs
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 Adaptec aic7899 Ultra160 SCSI grief


[... snip ...]

	If it turns out to be a firmware problem, is the firmware
upgradeable
or do I have to buy a new drive, in which case is there a blacklist?

	Tugrul Galatali

