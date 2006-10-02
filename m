Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965422AbWJBVkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965422AbWJBVkZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965424AbWJBVkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:40:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9942 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965422AbWJBVkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:40:24 -0400
Date: Mon, 2 Oct 2006 22:39:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Henne <henne@nachtwindheim.de>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       pbadari@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix in kerneldoc
Message-ID: <20061002213955.GB27561@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Henne <henne@nachtwindheim.de>, Andrew Morton <akpm@osdl.org>,
	pbadari@us.ibm.com, linux-kernel@vger.kernel.org
References: <451F98CB.3040509@nachtwindheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451F98CB.3040509@nachtwindheim.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2006 at 12:30:35PM +0200, Henne wrote:
> Fixes an kerneldoc error.
> Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
> 
> ---
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index ec46923..f789500 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1139,11 +1139,11 @@ success:
>  }
>  
>  /**
> - * __generic_file_aio_read - generic filesystem read routine
> + * generic_file_aio_read - generic filesystem read routine
>   * @iocb:	kernel I/O control block
>   * @iov:	io vector request
>   * @nr_segs:	number of segments in the iovec
> - * @ppos:	current file position
> + * @pos:	current file position
>   *
>   * This is the "read()" routine for all filesystems
>   * that can use the page cache directly.

Looks good - thank you a lot!
