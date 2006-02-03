Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWBCRrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWBCRrj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 12:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWBCRri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 12:47:38 -0500
Received: from mail-gw3.adaptec.com ([216.52.22.36]:5586 "EHLO
	mail-gw3.adaptec.com") by vger.kernel.org with ESMTP
	id S1751242AbWBCRri convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 12:47:38 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: RAID5 unusably unstable through 2.6.14
Date: Fri, 3 Feb 2006 12:47:36 -0500
Message-ID: <547AF3BD0F3F0B4CBDC379BAC7E4189F021C9924@otce2k03.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RAID5 unusably unstable through 2.6.14
Thread-Index: AcYo6MpEJsXBgo0cQW+UKPnpHWTySAAAJRIw
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Martin Drab" <drab@kepler.fjfi.cvut.cz>
Cc: "Phillip Susi" <psusi@cfl.rr.com>, "Bill Davidsen" <davidsen@tmr.com>,
       "Cynbe ru Taren" <cynbe@muq.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Drab [mailto:drab@kepler.fjfi.cvut.cz] sez:
> no access was possible at all to that block device entirely.

Then 'we' are missing an offline message (from SCSI/block or from a
check of the controller's array status).

bd_claim locking out access?

-- Mark
