Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751608AbWCBQxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbWCBQxK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 11:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWCBQxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 11:53:10 -0500
Received: from mail0.lsil.com ([147.145.40.20]:23545 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1751422AbWCBQxI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 11:53:08 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: Question: how to map SCSI data DMA address to virtual address?
Date: Thu, 2 Mar 2006 09:53:06 -0700
Message-ID: <9738BCBE884FDB42801FAD8A7769C2651420C1@NAMAIL1.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question: how to map SCSI data DMA address to virtual address?
Thread-index: AcY+GcdDBtAkU8AYS9+QoVt42RPB4w==
From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
To: "Ju, Seokmann" <Seokmann.Ju@engenio.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 02 Mar 2006 16:53:07.0022 (UTC) FILETIME=[C795B6E0:01C63E19]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In the 'scsi_cmnd' structure, there are two entries holding address
information for data to be transferred. One is 'request_buffer' and the
other one is 'buffer'.
In case of 'use_sg' is non-zero, those entries indicates the address of
the scatter-gather table.

Is there way to get virtual address (so that the data could be accessed
by the driver) of the actual data in the case of 'use_sg' is non-zero?

Any comments would be appreciated.


Thank you,

Seokmann
