Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbUHBUQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbUHBUQx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 16:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbUHBUQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 16:16:53 -0400
Received: from mer-tsm1.nasdaq.com ([206.200.253.23]:20745 "EHLO
	MER-TSM1.NASDAQ.COM") by vger.kernel.org with ESMTP id S262932AbUHBUQ0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 16:16:26 -0400
X-Server-Uuid: EECCD282-DD20-463F-80F0-CC7552CC1D9A
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: Booting from an I2O Adaptec zcr card
Date: Mon, 2 Aug 2004 16:16:07 -0400
Message-ID: <FFB5EEE014075A45A02FAE38D9F68141074649@mer-exch2.corp.nasdaq.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Booting from an I2O Adaptec zcr card
Thread-Index: AcR4zYuUbu8++DKUR72IMqC7G8kSnQ==
From: "Smith, Hibbard" <Hibbard.Smith@nasdaq.com>
To: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 02 Aug 2004 20:16:07.0882 (UTC)
 FILETIME=[8B97B2A0:01C478CD]
X-WSS-ID: 6D107E8D1V81446960-01-01
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, this is probably a stupid question, but I can't find the answer anywhere:

How can I use (kernel-2.6.7-bk20 or 2.6.8-rc2-bk11) the i2o driver as the boot driver with an Adaptec 2010S zcr adapter and a dual channel 7902.  I was able to get this working using the dpt-i2o driver, but since that seems to be going away and the i2o driver is replacing it, I'd like to use it instead.  I have all 4 parts of the i2o driver built (as modules) in my kernel, but what changes are required to make it load at boot time and booting through it instead of the dpt-i2o driver. Is this as simple as aliasing scsihostadapter to i2o in /etc/modprobe.conf?  If so, which of the 4 modules that comprise this driver would be referenced? assuming I can get by this issue, the RAID 5 on this adapter will show up as /dev/i2o/hda (now it's /dev/sda), at least that's what I glean from reading various stuff.  If that's so, will grub be able to find the boot drive?  It's configured in grub.conf as a labeled drive.  (label = /).

Smitty
Hibbard T. Smith, JR
Associate Vice President
Telecommunications Technical Services/Software Services
hibbard.smith@nasdaq.com
(203)385-4580


