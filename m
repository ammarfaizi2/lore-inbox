Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265745AbUA0V7v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 16:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265777AbUA0V7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 16:59:51 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:65414 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265745AbUA0V7t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 16:59:49 -0500
Subject: Re: [PATCH][2.6] PCI Scan all functions
From: John Rose <johnrose@austin.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Jake Moilanen <moilanen@austin.ibm.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, torvalds@osdl.org
In-Reply-To: <20040127211253.GA27583@kroah.com>
References: <1075222501.1030.45.camel@magik>
	 <20040127211253.GA27583@kroah.com>
Content-Type: text/plain
Message-Id: <1075240636.10285.38.camel@verve>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 27 Jan 2004 15:57:17 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi-

> Heh, I think the PPC64 people need to get together and all talk about
> this, as I just got a different patch, that solves much the same problem
> from John Rose (it's on the linuxppc64 mailing list.)
> 
> Can you two get together and not patch the same section of code to do
> the same thing in different ways?

These patches don't address the same problem.  Jake's problem has to do
with pci_scan_slot() ending too soon when going from function 0->7 at
boot time.  My problem has to do with pci_scan_slot() going too far from
function 0->7 at dlpar add time.  Greg, will follow up with you outside
of this thread.

Thanks-
John
-- 
John Rose <johnrose@austin.ibm.com>

