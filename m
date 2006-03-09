Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWCIWT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWCIWT3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 17:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbWCIWT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 17:19:29 -0500
Received: from mga03.intel.com ([143.182.124.21]:24742 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750766AbWCIWT2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 17:19:28 -0500
X-IronPort-AV: i="4.02,180,1139212800"; 
   d="scan'208"; a="11854658:sNHT99624847"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] /sys/firmware/efi/systab giving incorrect value for smbios
Date: Thu, 9 Mar 2006 14:19:24 -0800
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB00CA230C8@fmsmsx406.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] /sys/firmware/efi/systab giving incorrect value for smbios
thread-index: AcY/vlNJZEUb6JAaRhO0v+KXZyCNTwECLMng
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "Matthew Garrett" <mjg59@srcf.ucam.org>,
       <mactel-linux-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Mar 2006 22:19:25.0980 (UTC) FILETIME=[8671DDC0:01C643C7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett <> wrote:
> Or, as an alternative, remove the virtual to physical mapping that
> efivars does. This requires fixing up IA64 to match. I've no idea
> which approach is right.

There's a patch (or set of patches?) in -mm from Bjorn that does 
this (retain the physical addresses), which I believe is the best
approach.  Particularly considering it alleviates a bunch of 
back-and-forth calculations in ACPI.

matt  
