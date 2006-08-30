Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbWH3BSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWH3BSE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 21:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWH3BSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 21:18:04 -0400
Received: from mx1.bluearc.com ([63.110.244.100]:46599 "EHLO
	us-mimesweeper.terastack.bluearc.com") by vger.kernel.org with ESMTP
	id S932301AbWH3BSC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 21:18:02 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 0x7f in SectorIdNotFound errors
Date: Tue, 29 Aug 2006 18:18:02 -0700
Message-ID: <CECD6E8A589E8447BC6E836C8369AFF50AD2EB77@us-email.terastack.bluearc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 0x7f in SectorIdNotFound errors
Thread-Index: AcbLnG3iUmSw5c1bTVqSNM8YA+fPPwAJtHXw
From: "Martin Dorey" <mdorey@bluearc.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> it would be very strange drive geometry to
> start a partition on an odd sector boundary

In which case, perhaps I should have mentioned this before:

martind@ithaki:~$ sudo fdisk -lu /dev/hdb

Disk /dev/hdb: 300.0 GB, 300069052416 bytes
255 heads, 63 sectors/track, 36481 cylinders, total 586072368 sectors
Units = sectors of 1 * 512 = 512 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/hdb1              63   586067264   293033601   83  Linux
martind@ithaki:~$

> If you force an fsck

I'll schedule some downtime but I thought the above might be worth
mentioning immediately.
-------------------------------------
Martin's Outlook, BlueArc Engineering

