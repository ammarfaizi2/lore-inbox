Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030287AbVJEVR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbVJEVR2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 17:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbVJEVR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 17:17:28 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:53659 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030287AbVJEVR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 17:17:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=hgEZANCBs8aBlwgSNUykEkMd6NCYWshGGd8rJUwE4vyU2agYpxBRjrKjfxQdtoY7GR+cPN92vJ4/PgeGIkdi8yGPxxR7dSlsMCLOl1umTkLIjnyti2E/59DozrefgvaaywrLenqo+gcCRxIkvnTovN09n6CM0AM3a+UJ55qYbl0=
Date: Thu, 6 Oct 2005 01:28:50 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Chris Ricker <kaboom@gatech.edu>,
       chris.ricker@genetics.utah.edu, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Documentation: ksymoops should no longer be used to decode Oops messages
Message-ID: <20051005212850.GD27229@mipter.zuzino.mipt.ru>
References: <200510052239.43492.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510052239.43492.jesper.juhl@gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 10:39:43PM +0200, Jesper Juhl wrote:
> Document the fact that ksymoops should no longer be used to decode Oops
> messages.

If it's considered harmful, better remove all references to ksymoops.
2.4 users will happily grab their copy of this file from 2.4 tree.

>  Ksymoops
>  --------
>  
> -If the unthinkable happens and your kernel oopses, you'll need a 2.4
> -version of ksymoops to decode the report; see REPORTING-BUGS in the
> -root of the Linux source for more information.
> +With a 2.4 kernel you need ksymoops to decode a kernel Oops message. With
> +2.6 kernels ksymoops is no longer needed and should not be used.

