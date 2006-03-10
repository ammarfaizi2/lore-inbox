Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932725AbWCJLEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725AbWCJLEs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 06:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932727AbWCJLEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 06:04:47 -0500
Received: from mail-gw3.adaptec.com ([216.52.22.36]:39900 "EHLO
	mail-gw3.adaptec.com") by vger.kernel.org with ESMTP
	id S932724AbWCJLEp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 06:04:45 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: HEADS UP for gdth driver users
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Date: Fri, 10 Mar 2006 12:04:41 +0100
Message-ID: <B51CDBDEB98C094BB6E1985861F53AF374EAED@nkse2k01.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: HEADS UP for gdth driver users
Thread-Index: AcZCsv/B8NzQ1nn/QDC/U+m8qk7CyABfxnKQ
From: "Leubner, Achim" <Achim_Leubner@adaptec.com>
To: "Christoph Hellwig" <hch@lst.de>, <linux-scsi@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are willing to test the changes. Could you please send the latest patch to me? 

Thanks,
Achim Leubner

=======================
Achim Leubner
Software Engineer / RAID drivers
ICP vortex GmbH / Adaptec Inc.
Phone: +49-351-8718291
 
-----Original Message-----
From: Christoph Hellwig [mailto:hch@lst.de] 
Sent: Mittwoch, 8. März 2006 14:20
To: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org; Leubner, Achim
Subject: HEADS UP for gdth driver users

Hi folks,

the gdth driver is the only driver using (and in this case abusing) the
scsi_request interface we plan to kill for 2.6.17.  I've sent a patch
that's a first step to convert the driver away from it a few weeks ago
but didn't get any response.  I urgently need testers to keep the driver
for 2.6.17+.  Else it'll be marked broken until we get a person to help
testing the changes needed to resurrect it.


