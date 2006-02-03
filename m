Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945927AbWBCTrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945927AbWBCTrV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945925AbWBCTrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:47:21 -0500
Received: from mail-gw3.adaptec.com ([216.52.22.36]:39648 "EHLO
	mail-gw3.adaptec.com") by vger.kernel.org with ESMTP
	id S1945927AbWBCTrU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:47:20 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: RAID5 unusably unstable through 2.6.14
Date: Fri, 3 Feb 2006 14:47:19 -0500
Message-ID: <547AF3BD0F3F0B4CBDC379BAC7E4189F021C99D3@otce2k03.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RAID5 unusably unstable through 2.6.14
Thread-Index: AcYo9dmMSZ+ARmJ6SRmlg5HA/vxaJgABFLNQ
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Martin Drab" <drab@kepler.fjfi.cvut.cz>,
       "Roger Heflin" <rheflin@atipa.com>
Cc: "Phillip Susi" <psusi@cfl.rr.com>, "Bill Davidsen" <davidsen@tmr.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Drab sez:
> S.M.A.R.T. should be able to do this. But last time I've 
> checked it wasn't 
> working with Linux and SCSI/SATA. Is this working now?

Smartctl works with the latest patches to the aacraid driver to SAS and
SATA products (no_uld_patch submitted originally in December)

>> Run the Verify (or Verify with Fix) Task on the controller, the
report
>> will indicate the reasons for inconsistencies.
>How do I run that? Any special tools for that?

Can be triggered in the BIOS, or using the Adaptec Management Tools.

-- Mark
