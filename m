Return-Path: <linux-kernel-owner+w=401wt.eu-S932071AbXAHU3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbXAHU3S (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 15:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbXAHU3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 15:29:18 -0500
Received: from nlpi043.sbcis.sbc.com ([207.115.36.72]:4224 "EHLO
	nlpi043.sbcis.sbc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932071AbXAHU3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 15:29:18 -0500
X-ORBL: [67.117.73.34]
Date: Mon, 8 Jan 2007 12:28:59 -0800
From: Tony Lindgren <tony@atomide.com>
To: Ram <vshrirama@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel compilation - errors
Message-ID: <20070108202858.GA28406@atomide.com>
References: <8bf247760701080518s3f58f5aax4250bca4a43e9d59@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bf247760701080518s3f58f5aax4250bca4a43e9d59@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Ram <vshrirama@gmail.com> [070108 05:18]:
> Hi,
>   Im using linux-2.6.14-omap2430.
> 
>   Im using TI omap 2430 SDP.
> 
>   When i compile it with the eldk toolchain.
> 
>   I get an error listed at the end of this mail.
> 
>  The error is simple - case values should be constants, However, the
> toolchain gcc 4.0
>  is complaining that case values are not constant.
> 
>  Actually, the some of the case values are defined as -
> 
>  case (u32)&CM_ICLKEN_WKUP:
>  case (u32)&CM_FCLKEN_WKUP:
> 
> However, the same code compiles with some other compilers (lower
> versions of gcc).
> 
>  I think all compilers should give the same error
> 
>  Why the difference in behaviour?.
> 
> Not sure, if the source located at linux.omap.com/pub is broken.
> Couldnt find the sources of linux kernel for omap2430 with higher
> versions of the linux kernel higher than 2.6.14.

Sounds like you're using TI's tree. In that case please contact TI for
support.

If you want to use the current git tree, please see:

http://www.kernel.org/git/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=summary

and

http://muru.com/linux/omap

Only minimal 2340 code is currently merged in the linux-omap git tree,
so YMMV.

Regards,

Tony
