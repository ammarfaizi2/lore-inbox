Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262745AbVAFGSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbVAFGSk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 01:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbVAFGSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 01:18:40 -0500
Received: from fmr15.intel.com ([192.55.52.69]:30183 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S262745AbVAFGSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 01:18:37 -0500
Subject: Re: ACPI-1138 Error starting with 2.6.10-bk3
From: Len Brown <len.brown@intel.com>
To: syphir@syphir.sytes.net
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <41DCCCF6.1030505@syphir.sytes.net>
References: <41DCCCF6.1030505@syphir.sytes.net>
Content-Type: text/plain
Organization: 
Message-Id: <1104992311.18175.433.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 06 Jan 2005 01:18:31 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-06 at 00:30, C.Y.M wrote:
> I have been getting the following ACPI errors since 2.6.10-bk3.  Is there some new configuration I 
> need to enable?

> Jan  5 09:00:14 nofear kernel:     ACPI-1138: *** Error: Method execution failed [\STRC] (Node 
> c14d8e20), AE_AML_BUFFER_LIMIT
> Jan  5 09:00:14 nofear kernel:     ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0._INI] 
> (Node c14d7b40), AE_AML_BUFFER_LIMIT

This is a bug uncovered by a recent bugfix in ACPICA 20041210.  We
should have a fix shortly, but you can revert the original fix here for
now:

http://linux.bkbits.net:8080/linux-2.6/cset@41c89c58By5_5UiBytaIrXbTqmQn0A


