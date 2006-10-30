Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161348AbWJ3Spl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161348AbWJ3Spl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 13:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030574AbWJ3Spl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 13:45:41 -0500
Received: from outbound-ash.frontbridge.com ([206.16.192.249]:38827 "EHLO
	outbound2-ash-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1030572AbWJ3Spk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 13:45:40 -0500
X-BigFish: VP
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: x86-64 with nvidia MCP51 chipset: kernel does not find HPET
Date: Mon, 30 Oct 2006 11:07:54 -0600
Message-ID: <1449F58C868D8D4E9C72945771150BDF153774@SAUSEXMB1.amd.com>
In-Reply-To: <1161987301.27225.212.camel@mindpipe>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: x86-64 with nvidia MCP51 chipset: kernel does not find
 HPET
Thread-Index: Acb6FXOSezlxLBlORiKzruvUQI88kgCMF0Qg
From: "Langsdorf, Mark" <mark.langsdorf@amd.com>
To: "Lee Revell" <rlrevell@joe-job.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
cc: "Clemens Ladisch" <clemens@ladisch.de>
X-OriginalArrivalTime: 30 Oct 2006 17:07:54.0422 (UTC)
 FILETIME=[F07BB560:01C6FC45]
X-WSS-ID: 6958EEE00Z4952963-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a 6 month old x86-64 machine with nvidia MCP51 chipset on which
> the kernel does not detect the HPET.  According to HPET maintainer
> Clemens Ladisch, this machine certainly has one, but it cannot be
> enabled for lack of hardware documentation.
> 
> Is there anything I can do to help debug this?

If the hardware is not providing the HPET description in ACPI,
there's little you can do, and most vendors do not provide
the HPET description.

Do you know if there's an entry for HPET in the ACPI?

-Mark Langsdorf
AMD, Inc.


