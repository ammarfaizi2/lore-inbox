Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbWA2KjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbWA2KjZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 05:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWA2KjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 05:39:25 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:49311 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750896AbWA2KjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 05:39:23 -0500
Date: Sun, 29 Jan 2006 02:38:41 -0800
From: Paul Jackson <pj@sgi.com>
To: "Bob Picco" <bob.picco@hp.com>
Cc: y-goto@jp.fujitsu.com, akpm@osdl.org, apw@shadowen.org, bob.picco@hp.com,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       linux-ia64@vger.kernel.org, tony.luck@intel.com, ak@suse.de,
       len.brown@intel.com, discuss@x86-64.org
Subject: Re: [PATCH 001/003]Fix unify mapping from pxm to node id.
Message-Id: <20060129023841.439a21af.pj@sgi.com>
In-Reply-To: <20060129034434.GO7306@localhost>
References: <20060123165644.C147.Y-GOTO@jp.fujitsu.com>
	<20060126074846.1a6dd300.pj@sgi.com>
	<20060128122758.CF50.Y-GOTO@jp.fujitsu.com>
	<20060127231517.4c0ce573.pj@sgi.com>
	<20060129034434.GO7306@localhost>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that I applied the patches correctly:
  x86-x86_64-ia64-unify-mapping-from-pxm-to-node-id.patch
  x86-x86_64-ia64-unify-mapping-from-pxm-to-node-id-fix.patch
  [PATCH 001/003]Fix unify mapping from pxm to node id. 
  [PATCH 002/003]Fix unify mapping from pxm to node id. 
  [PATCH 003/003]Fix unify mapping from pxm to node id. 

They compiled on a 2.6.16-rc1-mm3 source base, for archs:
  alpha arm i386 ia64 sparc x86_64

and they compiled and booted ok on SN2 (ia64 sn2_defconfig).

I just noticed as I typed the above that the last 3 patches all had the
same Subject "Fix unify mapping from pxm to node id."  Each patch
should have a different Subject (after the [...] is stripped.)

Other than that detail ... looks good.

	Acked-by: Paul Jackson <pj@sgi.com>

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
