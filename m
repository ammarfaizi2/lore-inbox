Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161222AbWASOUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161222AbWASOUG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 09:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161219AbWASOUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 09:20:06 -0500
Received: from fmr14.intel.com ([192.55.52.68]:35011 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S1161221AbWASOUE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 09:20:04 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2.6.15] ia64: use i386 dmi_scan.c
Date: Thu, 19 Jan 2006 06:19:42 -0800
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB00C26DFB1@fmsmsx406.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.15] ia64: use i386 dmi_scan.c
Thread-Index: AcYb18zaFZZzxc4DTNK5ldyq4P6Y1ABKzweA
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "Andi Kleen" <ak@suse.de>, "Bjorn Helgaas" <bjorn.helgaas@hp.com>
Cc: "Matt Domsch" <Matt_Domsch@dell.com>, <linux-ia64@vger.kernel.org>,
       <openipmi-developer@lists.sourceforge.net>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Jan 2006 14:19:45.0059 (UTC) FILETIME=[65701730:01C61D03]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <> wrote:
> Regarding physical vs virtual efi.smbios -- it sounds nasty to have
> such a difference in the EFI support for different architectures.
> Matthew, do you have a suggestion how this can be unified?

Yes, Bjorn and I talked about this offline.  I had a patch out there
a while back that converged this specifically for the acpi addresses.  
We should be able to convert them all to just one type.  

matt
