Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWBITOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWBITOU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 14:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWBITOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 14:14:20 -0500
Received: from mail0.lsil.com ([147.145.40.20]:65019 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1750717AbWBITOT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 14:14:19 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: megaraid bug in kobject_register when no device is present
Date: Thu, 9 Feb 2006 12:14:12 -0700
Message-ID: <9738BCBE884FDB42801FAD8A7769C265142063@NAMAIL1.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: megaraid bug in kobject_register when no device is present
Thread-Index: AcYtlYl8ZSedKUpHS42POWxpitcrRAAFyUxQ
From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
To: "Greg KH" <greg@kroah.com>, "Meelis Roos" <mroos@linux.ee>
Cc: "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 09 Feb 2006 19:14:13.0243 (UTC) FILETIME=[032BC4B0:01C62DAD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, February 09, 2006 11:26 AM Greg KH wrote:
> This means that the driver is trying to register with the same name as
> another driver on the same bus.
It has been duplicated and made change in megaraid legacy driver.
The module name for the driver will be 'megaraid_legacy' from 'megaraid'.
Patch will be followed soon.

Thank you,

Seokmann
