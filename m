Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267236AbUBMVo0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 16:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267237AbUBMVo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 16:44:26 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:8847 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S267236AbUBMVoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 16:44:22 -0500
Date: Fri, 13 Feb 2004 22:44:20 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org, linux-gcc@vger.kernel.org
Subject: Re: Kernel Cross Compiling
Message-ID: <20040213214420.GA32006@MAIL.13thfloor.at>
Mail-Followup-To: davidm@hpl.hp.com, linux-kernel@vger.kernel.org,
	linux-gcc@vger.kernel.org
References: <20040213205743.GA30245@MAIL.13thfloor.at> <16429.16944.521739.223708@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16429.16944.521739.223708@napali.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 01:31:28PM -0800, David Mosberger wrote:
> >>>>> On Fri, 13 Feb 2004 21:57:43 +0100, Herbert Poetzl <herbert@13thfloor.at> said:
> 
>   Herbert> I got all headers fixed, except for the ia64, which still
>   Herbert> doesn't work
> 
> Something sounds wrong here. You shouldn't have to patch headers.
> 
> A recipe for building ia32->ia64 cross-toolchain on Debian can be
> found here:
> 
>  http://www.gelato.unsw.edu.au/IA64wiki/CrossCompilation

that might work with the ia64 libraries and headers,
but it seems to fail, with the headers included in
the gcc tarball, for cross compiling, if you get it
to compile without (g)libc which should not be required
to build the crossgcc and the kernel, I would be very
interested ...

anyway, thanks for the url,
Herbert

> 	--david
> -
> To unsubscribe from this list: send the line "unsubscribe linux-gcc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
