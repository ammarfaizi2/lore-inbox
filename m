Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271058AbUJVKjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271058AbUJVKjO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 06:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271060AbUJVKjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 06:39:14 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:1547 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271058AbUJVKjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 06:39:11 -0400
Date: Fri, 22 Oct 2004 11:39:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-mm1
Message-ID: <20041022103910.GB17526@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20041022032039.730eb226.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022032039.730eb226.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   - reiser4: not sure, really.  The namespace extensions were disabled,
>     although all the code for that is still present.  Linus's filesystem
>     criterion used to be "once lots of people are using it, preferably when
>     vendors are shipping it".  That's a bit of a chicken and egg thing though.
>     Needs more discussion.

Your tree also has various rejected core changes for it still.

> +add-simple_alloc_dentry-to-libfs.patch
> 
>  Code refactoring

I think this should go into fs/dcache.c and be called something
like d_alloc_name or similar.

> +hfs-export-type-creator-via-xattr.patch

I haven't heard an answer on the comments on this on on -fsdevel yet..

> +make-__sigqueue_alloc-a-general-helper.patch
> 
>  posix timer code tweaks

Any reason it's marked inline now?

