Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbVHPXqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbVHPXqT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 19:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbVHPXqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 19:46:19 -0400
Received: from ns2.suse.de ([195.135.220.15]:31366 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750740AbVHPXqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 19:46:18 -0400
Date: Wed, 17 Aug 2005 01:46:17 +0200
From: Andi Kleen <ak@suse.de>
To: zach@vmware.com
Cc: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org, hpa@zytor.com,
       Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       m+Ian.Pratt@cl.cam.ac.uk, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zwame@arm.linux.org.uk
Subject: Re: [PATCH 6/14] i386 / Add some segment convenience functions
Message-ID: <20050816234617.GH27628@wotan.suse.de>
References: <200508110454.j7B4sVsL019549@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508110454.j7B4sVsL019549@zach-dev.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 09:54:31PM -0700, zach@vmware.com wrote:
> Add some convenient segment macros to the kernel.  This makes the
> rather obfuscated 'seg & 4' go away.

segment_from_ldt is a weird name for this. I wouldn't guess it to 
be a test for something. How about is_ldt_segment() instead? 

-Andi
