Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262576AbULPFEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbULPFEL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 00:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262582AbULPFEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 00:04:11 -0500
Received: from peabody.ximian.com ([130.57.169.10]:46802 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262576AbULPFDm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 00:03:42 -0500
Subject: Re: [RFC] Device Resource Management
From: Robert Love <rml@ximian.com>
To: Greg KH <greg@kroah.com>
Cc: ambx1@neo.rr.com, linux-kernel@vger.kernel.org, mochel@digitalimplant.org,
       len.brown@intel.com, shaohua.li@intel.com,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
In-Reply-To: <20041216041405.GA23223@kroah.com>
References: <20041211054509.GA2661@neo.rr.com>
	 <20041216041405.GA23223@kroah.com>
Content-Type: text/plain
Date: Thu, 16 Dec 2004 00:05:05 -0500
Message-Id: <1103173505.6052.282.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-15 at 20:14 -0800, Greg KH wrote:

> Why would it matter if we export this info to userspace?  Do any
> userspace programs care about this information?

We'd love to be able to view and manipulate resource information from
HAL.  As HAL replaces vendor-specific solutions such as, say, kudzu, it
will need to make device/driver decisions and implement work arounds, so
this information is incredibly invaluable, let alone just neat to have.

Note _requiring_ user-space to implement the resource allocation
strategy is an entirely different path, and I am not arguing that.  We'd
like to read it, if nothing else.

	Robert Love


