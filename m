Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265642AbUANBdk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 20:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265649AbUANBdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 20:33:40 -0500
Received: from fmr06.intel.com ([134.134.136.7]:20886 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S265642AbUANBdj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 20:33:39 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [ACPI] ACPI directories still exist with acpi off
Date: Wed, 14 Jan 2004 09:33:32 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720CC8@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] ACPI directories still exist with acpi off
Thread-Index: AcPaJBxkw0K7QeMIRAm/gfvjnyiZwgAGhthg
From: "Yu, Luming" <luming.yu@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>,
       "ACPI mailing list" <acpi-devel@lists.sourceforge.net>,
       "kernel list" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Jan 2004 01:33:32.0732 (UTC) FILETIME=[6BC3AFC0:01C3DA3E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Include acpi support into the kernel, but pass acpi=off on the command
> line. Somehow, acpi still manages to create its directories, but not
> in /proc/acpi but in /proc directly. Ouch.
How about this one:
http://bugme.osdl.org/attachment.cgi?id=1696&action=view
