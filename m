Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbUK2Sak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbUK2Sak (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 13:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbUK2Sah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 13:30:37 -0500
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:11 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S261479AbUK2Sab convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 13:30:31 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Licensing nit in glibc-kernheaders-2.4
Date: Mon, 29 Nov 2004 13:30:30 -0500
Message-ID: <C9AAAF1DB2411546B68C720B0D0630CB010A732D@ataexc01.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Licensing nit in glibc-kernheaders-2.4
Thread-Index: AcTWQYE/IC3GwUGUStyt9r6Pr6P94A==
From: "Foster, Glen A" <glen.foster@hp.com>
To: <linux-kernel@vger.kernel.org>
Cc: <ncorbic@sangoma.com>
X-OriginalArrivalTime: 29 Nov 2004 18:30:31.0038 (UTC) FILETIME=[81B249E0:01C4D641]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is truly a nit, I just ran across it by accident.  I filed a bug
against RH glibc-kernheaders and I was told to file the problem report
upstream by sending email to linux-kernel@vger.kernel.org and cc: the
developer -- so I added the one e-mail address in the file under
question.

In glibc-kernheaders-2.4, the file usr/include/linux/sdla_chdlc.h has a
boiler-plate license template that *almost* matches the one in the GNU
GPL, but there's a mis-spelling that some day should be corrected.  This
*is* a nit but could stand to be fixed; I certainly think it could wait
for an update.

Lines 9-12 of usr/include/linux/sdla_chdlc.h are:

<excerpt>
	This program is free software; you can redistribute it and/or
	modify it under the term of the GNU General Public License
	as published by the Free Software Foundation; either version
	2 of the License, or (at your option) any later version.
</excerpt>

This is almost exactly the boiler-plate needed for a correct licensing
reference to the GNU GPL, but not quite.  Line ten should be changed
to use the word "terms" instead of "term", as (a) there is more than
one term to the GPL that must be adhered to, and (b) the GPL mentions
specifically that the wording of said reference cannot be modified -
and it has been modified.

Thanks in advance for your consideration.  Best regards,

Glen A. Foster
Hewlett-Packard Company
Linux and Open Source Lab
