Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWAITYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWAITYh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 14:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWAITYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 14:24:37 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:7125 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751142AbWAITYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 14:24:35 -0500
Subject: Re: [patch 2/2] add x86-64 support for memory hot-add
From: keith <kmannth@us.ibm.com>
To: Yinghai Lu <yinghai.lu@amd.com>
Cc: Andi Kleen <ak@suse.de>, Matt Tolentino <metolent@cs.vt.edu>,
       akpm@osdl.org, discuss@x86-64.org,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <86802c440601091051h3752f6ddg6877e0c8aed7a407@mail.gmail.com>
References: <200601091521.k09FLU1t022321@ap1.cs.vt.edu>
	 <200601091636.21118.ak@suse.de>
	 <86802c440601091051h3752f6ddg6877e0c8aed7a407@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 09 Jan 2006 11:24:31 -0800
Message-Id: <1136834671.31043.100.camel@knk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-09 at 10:51 -0800, Yinghai Lu wrote:
> for Opteron NUMA, need to update
> 0. stop the DCT on the node that will plug the new DIMM
> 1. read spd_rom for the added dimm
> 2. init the ram size and update the memory routing table...
> 3. init the timing...
> 4. update relate info in TOM and TOM2, and MTRR, and e820
> 
> It looks like we need to get some code about ram init from LinuxBIOS.....

Is the AMD box not going to use the ACPI add-memory mechanism?


-- 
keith <kmannth@us.ibm.com>

