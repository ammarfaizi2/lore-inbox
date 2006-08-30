Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWH3Rfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWH3Rfu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 13:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWH3Rfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 13:35:50 -0400
Received: from mx1.bluearc.com ([63.110.244.100]:57608 "EHLO
	us-mimesweeper.terastack.bluearc.com") by vger.kernel.org with ESMTP
	id S1751207AbWH3Rfu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 13:35:50 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 0x7f in SectorIdNotFound errors
Date: Wed, 30 Aug 2006 10:35:50 -0700
Message-ID: <CECD6E8A589E8447BC6E836C8369AFF50AD2EC59@us-email.terastack.bluearc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 0x7f in SectorIdNotFound errors
Thread-Index: AcbLnG3iUmSw5c1bTVqSNM8YA+fPPwAvi7Hg
From: "Martin Dorey" <mdorey@bluearc.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you force an fsck do you see any errors ?

Some leaks but that's all?

martind@ithaki:~$ sudo e2fsck -f -n /dev/hdb1
e2fsck 1.37 (21-Mar-2005)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Block bitmap differences:  -(27960582--27961605) -(27961607--27962101)
Fix? no

Free blocks count wrong for group #1126 (17197, counted=17216).
Fix? no

Free blocks count wrong for group #1293 (17902, counted=18046).
Fix? no

Free blocks count wrong (40205032, counted=40205195).
Fix? no

Free inodes count wrong for group #852 (16301, counted=16302).
Fix? no

Free inodes count wrong for group #1126 (15834, counted=15837).
Fix? no

Free inodes count wrong for group #1292 (15671, counted=15677).
Fix? no

Free inodes count wrong (35235302, counted=35235312).
Fix? no


u89: ********** WARNING: Filesystem still has errors **********

u89: 1399322/36634624 files (1.7% non-contiguous), 33053368/73258400
blocks
martind@ithaki:~$
-------------------------------------
Martin's Outlook, BlueArc Engineering
