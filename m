Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264388AbUFPSP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264388AbUFPSP3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 14:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbUFPSP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 14:15:29 -0400
Received: from fmr05.intel.com ([134.134.136.6]:6531 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S264401AbUFPSPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 14:15:20 -0400
Date: Wed, 16 Jun 2004 11:14:34 -0700
Message-Id: <200406161814.i5GIEYCA029815@penguin2.jf.intel.com>
From: Rusty Lynch <rusty@linux.jf.intel.com>
To: faith@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: Why allow only one auditing consumer?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like the way the auditing code is using netlink there can only be
one user space process that recieves auditing messages.

Is this correct?

I was looking into using auditing for monitoring the lifetime of a set of 
processes, but I don't want my super-init type of component to rule out using
SELinux (or whatever else was planning on consuming auditing messages.)

Assuming I understood the code correctly, would a patch that enabled multiple
auditing consumers be in-line with the goals of the sycall auditing mechanism?

    --rusty


