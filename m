Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266299AbUBLIlx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 03:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266302AbUBLIlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 03:41:53 -0500
Received: from mail.shareable.org ([81.29.64.88]:48769 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266299AbUBLIlw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 03:41:52 -0500
Date: Thu, 12 Feb 2004 08:41:10 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Kyle <kyle@southa.com>
Cc: Bas Mevissen <ml@basmevissen.nl>, linux-kernel@vger.kernel.org
Subject: Re: ICH5 with 2.6.1 very slow
Message-ID: <20040212084110.GB20898@mail.shareable.org>
References: <164601c3ec06$be8bd5a0$b8560a3d@kyle> <40227C20.80404@basmevissen.nl> <167301c3ec0d$4d8508c0$b8560a3d@kyle> <40227D9D.2070704@basmevissen.nl> <168301c3ec0e$24698be0$b8560a3d@kyle> <4023682E.3060809@basmevissen.nl> <001101c3ecf8$b0f50cc0$b8560a3d@kyle> <40274581.4030002@basmevissen.nl> <004501c3f0ae$ecdd2ec0$b8560a3d@kyle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004501c3f0ae$ecdd2ec0$b8560a3d@kyle>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle wrote:
> Today I tried with compile the kernel 2.6.1 with:
> 
> IGNORE word93 Validation BITS (IDEDMA_IVB) = y
> 
> The result looks a bit better, got 30MB/s at /dev/hda and 37MB/s at /dev/hdc
> (38MB/s and 55MB/s at kernel 2.4.20)

Aha...

Have a look at the thread called "[RFC] IDE 80-core cable detect -
chipset-specific code to over-ride eighty_ninty_three()".

It specifically deals with ICH5 and is probably the same problem as
you're seeing.

-- Jamie
