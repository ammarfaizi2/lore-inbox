Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932773AbWBURb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932773AbWBURb1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 12:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932777AbWBURb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 12:31:26 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:54961 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S932773AbWBURb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 12:31:26 -0500
In-Reply-To: <43FB2573.3070909@us.ibm.com>
References: <43FB2573.3070909@us.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <86d3c1ac08482df0e353ae9a5afa66bd@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: Dave Hansen <haveblue@us.ibm.com>, xen-devel@lists.xensource.com,
       lkml <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [Xen-devel] [ PATCH 2.6.16-rc3-xen 1/3] sysfs: export Xen hypervisor attributes to sysfs
Date: Tue, 21 Feb 2006 17:37:35 +0000
To: "Mike D. Day" <ncmike@us.ibm.com>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 21 Feb 2006, at 14:36, Mike D. Day wrote:

> # HG changeset patch
> # User mdday@dual.silverwood.home
> # Node ID d296aaf07bcb4141c6dc2a1bfa7d183f919c2167
> # Parent  a05e56904e7e5e86aae5a2e022621caaf7b3a6f5
> define constants for array sizes. Allows linux users of this file to 
> avoid #typedefs. Existing typedefs work as before.
> signed-off-by: Mike D. Day <ncmike@us.ibm.com>

I took this patch, but renamed the xxx_LEN macros to more closely match 
the typedef names.

  -- Keir

