Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbWHWOTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbWHWOTI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 10:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWHWOTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 10:19:07 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:52618 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964895AbWHWOTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 10:19:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=lzTJqRH6neLXuTHFPGZQp1MOUGjxZtCfcBsK3Z1hHcHfob4SPtKmTNrdxcfMtwrfGjYu49DMK3TDztHD6Jo7Tx7/6mTOlN4BMl6JVqpdNBW9oqhnIMP+Y9urykeyiQC05atVQvKQ3I4Z0ZXwWoG5xdmJGGl2EonaNMeoj5r8njo=
Date: Wed, 23 Aug 2006 18:18:48 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, okuji@enbug.org
Subject: Re: [patch 0/5] RFC: fault-injection capabilities
Message-ID: <20060823141848.GF10449@martell.zuzino.mipt.ru>
References: <20060823113243.210352005@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060823113243.210352005@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 08:32:43PM +0900, Akinobu Mita wrote:
> This patch set provides some fault-injection capabilities.
>
> - kmalloc failures
>
> - alloc_pages() failures
>
> - disk IO errors
>
> We can see what really happens if those failures happen.

What bugs fault-injection has already found? Ingo and Sons fixed quite
a few, _before_ lockdep was merged.

