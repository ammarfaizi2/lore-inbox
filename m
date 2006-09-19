Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752048AbWISUSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbWISUSk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 16:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752047AbWISUSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 16:18:40 -0400
Received: from mail0.lsil.com ([147.145.40.20]:46824 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1752016AbWISUSj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 16:18:39 -0400
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Multi-Initiator SAS
Date: Tue, 19 Sep 2006 14:18:36 -0600
Message-ID: <664A4EBB07F29743873A87CF62C26D7032CDC0@NAMAIL4.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Multi-Initiator SAS
Thread-Index: AcbcICUaIAo3IGXNSR6w1eTrl6uMMQACHRvg
From: "Moore, Eric" <Eric.Moore@lsil.com>
To: "Darrick J. Wong" <djwong@us.ibm.com>, <linux-scsi@vger.kernel.org>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Sep 2006 20:18:37.0581 (UTC) FILETIME=[CA3373D0:01C6DC28]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, September 19, 2006 1:15 PM,  Darrick J. Wong wrote:

> Alexis and I connected both a Adaptec 9410 and a LSI 1064E 
> SAS initiator
> to an expander.  Both machines saw the disks attached to the expander,
> and both could send I/Os to the disks.  So far, so good.
> 
> We then connected a SATA disk to the expander.  libsas BUGd up in
> sas_ex_discover_end_dev (sas_expander.c:636):
> 
> BUG_ON(sas_port_add(phy->port) != 0);
> 

Which expander are you using?  I believe James has some sata work
arounds
for the sasx12, which has byte ordering issues.

Eric
