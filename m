Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbUFWV4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbUFWV4V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 17:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbUFWVz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 17:55:58 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:63168 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262238AbUFWVzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:55:19 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6] Altix serial driver
Date: Wed, 23 Jun 2004 17:54:56 -0400
User-Agent: KMail/1.6.2
Cc: Pat Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org, erikj@sgi.com
References: <Pine.SGI.3.96.1040623094239.19458C-100000@fsgi900.americas.sgi.com> <20040623143801.74781235.akpm@osdl.org>
In-Reply-To: <20040623143801.74781235.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406231754.56837.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, June 23, 2004 5:38 pm, Andrew Morton wrote:
> Pat Gefre <pfg@sgi.com> wrote:
> > 2.6 patch for our console driver. We converted the driver to use the
> > serial core functions. Also some changes to use sysfs/udev and a
> > different major number.
>
> This patch broke x86 `allmodconfig' and `allyesconfig'.  I fixed it with
> the below patch.  Probably the condition should be IA64_SGI_SN2, yes?

IA64_GENERIC | IA64_SGI_SN2

Jesse
