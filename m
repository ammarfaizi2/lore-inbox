Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262369AbVAUOEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbVAUOEJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 09:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbVAUOEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 09:04:08 -0500
Received: from [202.125.86.130] ([202.125.86.130]:4826 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S262369AbVAUOEF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 09:04:05 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Subject: FATAL: Error inserting fm -- invalid module format
Date: Fri, 21 Jan 2005 19:38:56 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB348112B93D8@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FATAL: Error inserting fm -- invalid module format
Thread-Index: AcT/vyMnpkTUwu5rS9ykubuHa91r6A==
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

We were developed a block device driver on linux-2.6.x kernel. We want
to distribute our driver as a RPM Binary. We are using the SuSE 9.1 with
2.6.5-7.71 kernel.

We build the RPM file using the fm.ko file on SuSE 9.1 with 2.6.5-7.71
kernel where fm.ko indicates our Block Driver module.  When I try to run
the RPM file on a different kernel version it has given the following
error message.

FATAL: Error inserting fm
(/lib/modules/2.6.4-52-default/kernel/drivers/block/fm.ko): Invalid
module format

As I know the error message indicates that I compiled the driver under
2.6.5-7.71 kernel where as I am trying to insert the module in
2.6.4-52-default kernel.

My question is: Is it possible to compile and build a .ko file with out
including the version information? (i.e. I want to build a RPM file
using fm.ko file which was compiled using 2.6.5-7.71 and to run the RPM
file on a different kernel versions.)

We are not very sure of how to achieve this. 
Please help us address this issue.

Thanks in advance and regards,
Srinivas G
