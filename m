Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270426AbTHLPKe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 11:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270438AbTHLPKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 11:10:34 -0400
Received: from fmr04.intel.com ([143.183.121.6]:19689 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S270426AbTHLPK3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 11:10:29 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [patch] move efivars to drivers/efi
Date: Tue, 12 Aug 2003 08:10:23 -0700
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE5DC@fmsmsx406.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] move efivars to drivers/efi
Thread-Index: AcNeMXwEo/YKYJpPQiq3CrYNdpdCQgCsh6NA
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "Matt Domsch" <Matt_Domsch@Dell.com>, "Patrick Mochel" <mochel@osdl.org>
Cc: "Matt Tolentino" <metolent@snoqualmie.dp.intel.com>,
       <davidm@napali.hpl.hp.com>, <torvalds@osdl.org>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Aug 2003 15:10:24.0081 (UTC) FILETIME=[DAC6CC10:01C360E3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Yes - have you considered doing a sysfs interface instead 
> of procfs? :)
> 
> It's crossed my mind, but I haven't had much time to spend on 
> IA-64 the
> past year, and that isn't likely to change soon...  I think 
> the only tool
> that uses /proc/efi/vars is efibootmgr, which would also need 
> to learn of
> a move to /sys.  Your binary-blob interface for sysfs is 
> exactly the right
> thing to use for it though.
> 
> Anyone want to take a stab at switching it, or do you want to 
> wait for me
> to have time?

Sure, I'll see if I can cook this up in the next few days and send an updated patch...

matt
