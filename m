Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262617AbUKXLTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbUKXLTv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 06:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262618AbUKXLTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 06:19:50 -0500
Received: from cantor.suse.de ([195.135.220.2]:49296 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262616AbUKXLTs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 06:19:48 -0500
Date: Wed, 24 Nov 2004 11:45:14 +0100
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: "Zou, Nanhai" <nanhai.zou@intel.com>, hugh@veritas.com, chrisw@osdl.org,
       torvalds@osdl.org, tony.luck@intel.com, schwidefsky@de.ibm.com,
       ak@suse.de, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH 1/2] setup_arg_pages can insert overlapping vma
Message-ID: <20041124104514.GD10495@wotan.suse.de>
References: <894E37DECA393E4D9374E0ACBBE7427013C9AB@pdsmsx402.ccr.corp.intel.com> <20041123172309.60d9e9c1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123172309.60d9e9c1.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 05:23:09PM -0800, Andrew Morton wrote:
> "Zou, Nanhai" <nanhai.zou@intel.com> wrote:
> >
> > I think ia64 ia32
> > subsystem is not vulnerable to this kind of overlapping vm problem,
> > because it does not support a.out binary format, 
> > X84_64 is vulnerable to this. 
> 
> Martin, Andi and Tony: could we please get a 2.6.10 ack on this from you?

Looks good to me.

-Andi
