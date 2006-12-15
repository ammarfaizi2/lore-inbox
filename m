Return-Path: <linux-kernel-owner+w=401wt.eu-S1752161AbWLOOAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161AbWLOOAS (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 09:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752160AbWLOOAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 09:00:18 -0500
Received: from khc.piap.pl ([195.187.100.11]:53236 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152AbWLOOAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 09:00:16 -0500
X-Greylist: delayed 1555 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 09:00:16 EST
To: Adrian Bunk <bunk@stusta.de>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove the broken SCSI_SEAGATE driver
References: <20061212162238.GR28443@stusta.de>
	<1165966274.5903.56.camel@mulgrave.il.steeleye.com>
	<20061213000902.GD28443@stusta.de>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Fri, 15 Dec 2006 14:34:13 +0100
In-Reply-To: <20061213000902.GD28443@stusta.de> (Adrian Bunk's message of "Wed, 13 Dec 2006 01:09:02 +0100")
Message-ID: <m3wt4tp9ka.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> There must have been a compile error that has since been fixed, but I 
> don't remember the details of this specific driver and I don't have 
> such old compile logs anymore.

I wonder if we could gather some usage statistics, especially WRT
really old hardware.

Perhaps we could invent some MODULE_WARN_OBSOLETE thing which would
warn users about their drivers being removed in +6m (or maybe +12m),
unless they let us know at http://qwe or mailto:ads?

I find it really hard to believe there are still users of things like
CDU-31A CDs, XT MFM disk controllers, or NCR5380 SCSI host adapters
(especially the real ones, not DOMEX etc. clones bundled with scanner
just ~ 10 years ago).
-- 
Krzysztof Halasa
