Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267844AbTGHWso (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 18:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267857AbTGHWso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 18:48:44 -0400
Received: from fmr02.intel.com ([192.55.52.25]:51437 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S267844AbTGHWsk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 18:48:40 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Race condition between aio_complete and aio_read_evt
Date: Tue, 8 Jul 2003 16:03:07 -0700
Message-ID: <41F331DBE1178346A6F30D7CF124B24B2A4888@fmsmsx409.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Race condition between aio_complete and aio_read_evt
Thread-Index: AcNFpLT3I10WJ4EURuC/BCld1ztinQAAB7Rg
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Stephen Hemminger" <shemminger@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-aio@kvack.org>
X-OriginalArrivalTime: 08 Jul 2003 23:03:08.0519 (UTC) FILETIME=[18D74F70:01C345A5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Stephen Hemminger [mailto:shemminger@osdl.org] 
> Sent: Tuesday, July 08, 2003 4:00 PM
> Subject: Re: Race condition between aio_complete and aio_read_evt

> Make those smp_* memory barrier's because they don't matter on UP.

Certainly, thanks for pointing that out.  I was about to say that as
well.

- Ken
