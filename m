Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317599AbSFMNVh>; Thu, 13 Jun 2002 09:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317605AbSFMNVg>; Thu, 13 Jun 2002 09:21:36 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:50094 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S317599AbSFMNVf>; Thu, 13 Jun 2002 09:21:35 -0400
Date: Thu, 13 Jun 2002 14:45:42 +0200
From: Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 inline abuse...
Message-ID: <20020613144542.E1944@linux-m68k.org>
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <3D072767.7030300@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2002 at 12:50:15PM +0200, Martin Dalecki wrote:
> The attached patch is trying to address the most obvious
> abuses or inadequacies in the usage of the inline attribute
> to functions. Many of the remaining usages should be removed
> as well since apparently GCC got really good at figuring out
> on its own whatever it makes sense to inline a function or not.

do you compile your kernels with -O3 or -finline-functions?
Otherwise gcc should not inline anything at all without the
explicit inline keyword.

Richard

