Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbVHLVJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbVHLVJV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 17:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbVHLVJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 17:09:21 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:62913 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932091AbVHLVJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 17:09:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=QYx/I1JuH1Z5qw7IlQbdlK2qhBmKyNuONfjX3uB26dHuY/b92spoE71fW+IG15nbx9G4gGqU4SmO8Xb+gjBoJj/7lOgqM26THZrG6zCb21EDrcyCJzg4PAfksaUe+QqzENze83MCxd1ptD4TLyz73L44nkLXFpUWoD+CkXo6x7w=
Date: Sat, 13 Aug 2005 01:17:46 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [patch 01/39] comment typo fix
Message-ID: <20050812211746.GC13689@mipter.zuzino.mipt.ru>
References: <20050812173130.2EDD524B4FD@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050812173130.2EDD524B4FD@zion.home.lan>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 07:31:29PM +0200, blaisorblade@yahoo.it wrote:
> smp_entry_t -> swap_entry_t
> 
> Too short changelog entry?

No, just wrong patch with non-descriptive subject line.

> --- linux-2.6.git/include/linux/swapops.h~fix-typo
> +++ linux-2.6.git-paolo/include/linux/swapops.h
> @@ -4,7 +4,7 @@
>   * the low-order bits.
>   *
>   * We arrange the `type' and `offset' fields so that `type' is at the five
> - * high-order bits of the smp_entry_t and `offset' is right-aligned in the
> + * high-order bits of the swap_entry_t and `offset' is right-aligned in the
>   * remaining bits.
>   *
>   * swp_entry_t's are *never* stored anywhere in their arch-dependent format.
      ^^^^^^^^^^^

