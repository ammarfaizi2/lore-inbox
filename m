Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270029AbUJHQkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270029AbUJHQkB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 12:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270015AbUJHQjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 12:39:03 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:5085 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S270006AbUJHQiA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 12:38:00 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: cngam@sgi.com
Subject: Re: [PATCH] 2.6 SGI Altix I/O code reorganization
Date: Fri, 8 Oct 2004 09:37:33 -0700
User-Agent: KMail/1.7
Cc: Matthew Wilcox <matthew@wil.cx>, Grant Grundler <iod00d@hp.com>,
       "Luck, Tony" <tony.luck@intel.com>, Patrick Gefre <pfg@sgi.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
References: <B8E391BBE9FE384DAA4C5C003888BE6F0221C989@scsmsx401.amr.corp.intel.com> <41645BDE.E9732310@sgi.com> <4166AF3D.9080808@sgi.com>
In-Reply-To: <4166AF3D.9080808@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410080937.33631.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, October 8, 2004 8:16 am, Colin Ngam wrote:
> Now, if we can remove the static from pci_root_ops, I can use it in
> io_init.c, that would be cleanest and that was what we started with.
> This is what the patch would look like ontop of the 002_add* patch:

Yep, this looks good to me Colin.

> +extern struct pci_ops pci_root_ops;
> +
> +extern struct pci_ops pci_root_ops;
> +

...but of course you don't need to extern it twice :)

> We need a resolution so that Tony can proceed.  Silence is not going to
> help.

You've got my vote.

Jesse
