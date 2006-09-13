Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWIMWeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWIMWeF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 18:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWIMWeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 18:34:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11466 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751235AbWIMWeD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 18:34:03 -0400
Date: Wed, 13 Sep 2006 15:31:58 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       zaitcev@redhat.com
Subject: Re: 2.6.18-rc6-mm2: rmmod ohci_hcd oopses on HPC 6325
Message-Id: <20060913153158.612ef473.zaitcev@redhat.com>
In-Reply-To: <Pine.LNX.4.44L0.0609131441080.6684-100000@iolanthe.rowland.org>
References: <200609131558.03391.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0609131441080.6684-100000@iolanthe.rowland.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.2; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2006 14:44:48 -0400 (EDT), Alan Stern <stern@rowland.harvard.edu> wrote:

> This problem has already been identified by Pete Zaitcev in this thread:
> 
> 	http://marc.theaimsgroup.com/?t=115769512800001&r=1&w=2
> 
> Perhaps Pete has an updated patch to fix the problem.  If not, I could 
> write one.

No, not yet. I am working on getting David's approach with irq = -1
tested at Stratus. Since it was the only reproducer known to me, I wanted
to test. Now that Rafael has a fault case, I'll expedite.

-- Pete
