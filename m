Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWDLOdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWDLOdF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 10:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWDLOdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 10:33:04 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:34138
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751184AbWDLOdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 10:33:03 -0400
Message-Id: <443D2BD6.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Wed, 12 Apr 2006 16:33:26 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: <xen-devel@lists.xensource.com>, <linux-kernel@vger.kernel.org>
Subject: apic= and {mps,acpi_madt}_oem_check
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can anyone explain what the point is to allow specifying the APIC model (for i386 Linux and both i386 and x86-64 Xen) on
the command line, yet overriding it unconditionally if the MPS and/or the ACPI tables indicate a special system?
Shouldn't the APIC replacement be suppressed in that case?

Thanks, Jan
