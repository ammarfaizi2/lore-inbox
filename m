Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbUCIMRK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 07:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbUCIMRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 07:17:10 -0500
Received: from [202.125.86.130] ([202.125.86.130]:23687 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S261895AbUCIMRI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 07:17:08 -0500
Content-class: urn:content-classes:message
Subject: RE: disable partitioning!
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Tue, 9 Mar 2004 17:43:38 +0530
X-MIMEOLE: Produced By Microsoft Exchange V6.5.6944.0
Message-ID: <1118873EE1755348B4812EA29C55A97217632E@esnmail.esntechnologies.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: disable partitioning!
Thread-Index: AcQFxCj9GI7VWyvaQh+cIFZhvnXTpAACuk+A
From: "Jinu M." <jinum@esntechnologies.co.in>
To: "Stefan Smietanowski" <stesmi@stesmi.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello Stefan.

> We are writing a block device driver for 2.4.x kernel.
> I want to know how to indicate to the filesystem that our block driver does not support partitions.
> I mean fdisk should not be allowed on disks supported by our block driver.

You can run fdisk on a file if you want to, it doesn't care what type of
block device it is. What you're really asking for is a way to make the
kernel not read the partition table if it exists on the device and
that's something else.

So then how do I stop kernel from reading the partition table?

-Jinu

