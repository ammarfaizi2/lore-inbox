Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTJXQG4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 12:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbTJXQG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 12:06:56 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:28296 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262373AbTJXQGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 12:06:54 -0400
Subject: Re: [Evms-devel] device-mapper & bd_claim
To: Martin Waitz <tali@admingilde.org>
Cc: dm-devel@sistina.com, evms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OFE867C898.653AA06D-ON85256DC9.0057E7C5-86256DC9.0058DE03@us.ibm.com>
From: Don Mulvey <dlmulvey@us.ibm.com>
Date: Fri, 24 Oct 2003 11:06:08 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 6.0.2CF2 PMR38084
 MIAS5SCKSP SASF5LTQFD GCHU5LFQD5 JHEG5PKRJT MIAS5RMQQF ALEE5RFGW8+|October
 16, 2003) at 10/24/2003 12:06:10
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>the problem seems to be the addition of bd_claim in 2.6:
>upon mounting the root filesystem, hda1 is claimed by the filesystem.
>thus, hda is claimed by the bd_claim code, too.
>evms tries to setup dm-tables using hda and fails to claim the device

I just saw this last night with 2.6.test6. Haven't had a chance to look at
it though. Couldn't activate compatibility vols on hda. Evms vols were
fine.

-Don

