Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265193AbUAZV6n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 16:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265216AbUAZV6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 16:58:43 -0500
Received: from fmr04.intel.com ([143.183.121.6]:6589 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S265193AbUAZV6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 16:58:42 -0500
Subject: Re: [PATCH] 2.4/2.6 use xdsdt to print table header
From: Len Brown <len.brown@intel.com>
To: Alex Williamson <alex.williamson@hp.com>
Cc: linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <1073953935.6497.173.camel@patsy.fc.hp.com>
References: <1073953935.6497.173.camel@patsy.fc.hp.com>
Content-Type: text/plain
Organization: 
Message-Id: <1075154310.2485.35.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 26 Jan 2004 16:58:31 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Accepted.

Thanks Alex,
-Len

On Mon, 2004-01-12 at 19:32, Alex Williamson wrote:
>    I'm resending this patch to get it into the main ACPI source.  This
> fixes a problem where the DSDT pointer in the FADT is NULL because it
> uses the 64bit XDSDT instead.  The current code is happy to map a NULL
> address and return success to the caller.  This can crash the system or
> printout garbage headers to the console.  It's a simple matter to check
> table revision and use the XDSDT in favor of the DSDT.  This has been
> living happily in both the 2.4 and 2.6 ia64 tree for some time.  Please
> accept.  Thanks,
> 
> 	Alex

