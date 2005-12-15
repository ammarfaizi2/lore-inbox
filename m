Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbVLOO6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVLOO6k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbVLOO6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:58:39 -0500
Received: from emulex.emulex.com ([138.239.112.1]:14473 "EHLO
	emulex.emulex.com") by vger.kernel.org with ESMTP id S1750756AbVLOO6i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:58:38 -0500
From: James.Smart@Emulex.Com
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [GIT PATCH] final SCSI fixes for 2.6.15-rc5
Date: Thu, 15 Dec 2005 09:58:23 -0500
Message-ID: <9BB4DECD4CFE6D43AA8EA8D768ED51C2276D38@xbl3.emulex.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [GIT PATCH] final SCSI fixes for 2.6.15-rc5
Thread-Index: AcYBDn5FXjjseAIMQFmSTeMSz+g4igAeVplg
To: <mdr@sgi.com>, <James.Bottomley@SteelEye.com>
Cc: <torvalds@osdl.org>, <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 1 - fc transport change gets really noisy if targets disappear from
> >     the fabric due to recursion on the workqueue.  I've 
> seen recursion
> >     depths > 40 and it's only really limited by the number 
> of targets
> >     on a fibre channel fabric.  It's unknown (to me) what 
> side effects
> >     this recursion might have if the number of targets is in the
> >     hundreds, which is not uncommon for our customers.  James Smart
> >     is aware of this and is working on a solution.
> >     See my posting of 12/2/2005 and replies.
> >     "2.6.15-rc4 error messages with multiple qla2300 hba 
> ports on fabric".


The patch I just posted to linux-scsi fixes this issue.

-- james s
