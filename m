Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264869AbUE0QSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264869AbUE0QSG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 12:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264874AbUE0QSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 12:18:05 -0400
Received: from fmr05.intel.com ([134.134.136.6]:24521 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S264869AbUE0QSA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 12:18:00 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: idebus setup problem (2.6.7-rc1)
Date: Fri, 28 May 2004 00:16:19 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F842DB1E1@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: idebus setup problem (2.6.7-rc1)
Thread-Index: AcREAkZsEHP8WnQVRZqxb+9Wq1pZ/gAAoQOg
From: "Zhu, Yi" <yi.zhu@intel.com>
To: "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Auzanneau Gregory" <mls@reolight.net>,
       "Jeff Garzik" <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 27 May 2004 16:16:20.0202 (UTC) FILETIME=[F230B4A0:01C44405]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> 
> It breaks all "idex=" and "hdx=" options.
> Please take a look at how ide_setup().

Yes, thanks for pointing out. Maybe we need some
wildcard support. If module_param() can do this, that's
great.

-yi
