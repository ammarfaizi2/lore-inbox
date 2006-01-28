Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932539AbWA1HQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbWA1HQP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 02:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbWA1HQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 02:16:15 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:56262 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932535AbWA1HQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 02:16:14 -0500
Date: Fri, 27 Jan 2006 23:15:17 -0800
From: Paul Jackson <pj@sgi.com>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: akpm@osdl.org, apw@shadowen.org, bob.picco@hp.com,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       linux-ia64@vger.kernel.org, tony.luck@intel.com, ak@suse.de,
       len.brown@intel.com, discuss@x86-64.org
Subject: Re: [PATCH 001/003]Fix unify mapping from pxm to node id.
Message-Id: <20060127231517.4c0ce573.pj@sgi.com>
In-Reply-To: <20060128122758.CF50.Y-GOTO@jp.fujitsu.com>
References: <20060123165644.C147.Y-GOTO@jp.fujitsu.com>
	<20060126074846.1a6dd300.pj@sgi.com>
	<20060128122758.CF50.Y-GOTO@jp.fujitsu.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yasunori-san,

Thank-you for updating your patch.

However I am still puzzled by one detail.

Your latest patchset removes the defines:
-#define MAX_PXM_DOMAINS	256	/* 1 byte and no promises about values */

and:
-#define MAX_PXM_DOMAINS (256)

but continues to have code using MAX_PXM_DOMAINS.  I am unable
to compile ia64 with it now, for lack of this define.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
