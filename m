Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbUDMPXN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 11:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263591AbUDMPXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 11:23:13 -0400
Received: from pat.qlogic.com ([198.70.193.2]:36750 "EHLO avexch01.qlogic.com")
	by vger.kernel.org with ESMTP id S261156AbUDMPXM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 11:23:12 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2.6.5-mm4
Date: Tue, 13 Apr 2004 08:22:46 -0700
Message-ID: <B179AE41C1147041AA1121F44614F0B0DD005A@AVEXCH02.qlogic.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.5-mm4
Thread-Index: AcQhayXFPK06Yc2oSfepWH6edaXnCA==
From: "Andrew Vasquez" <andrew.vasquez@qlogic.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Apr 2004 15:22:12.0812 (UTC) FILETIME=[186B50C0:01C4216B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 12, 2004 9:54 PM, Sam Ravnborg wrote:
> On Mon, Apr 12, 2004 at 01:15:24PM -0700, Andrew Vasquez wrote:
> > 	  LD [M]  /root/Drivers/8.x/80000b12-pre14/qla2xxx.o 	/bin/sh:
> > line 1: 
> > /root/Drivers/8.x/80000b12-pre14/.tmp_versions/qla2xxx.mod: No such
> > file or directory
> 
> The external module support failed to create the directory:
> $PWD/.tmp_version 
> 
> It was no deleted during make clean either - thats why it
> slipped through.
> Here is a patch to fix it.
>

The patch fixed the problem against mm4.  mm5 appears to have the fix
also.

Thanks,
Andrew Vasquez
