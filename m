Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264195AbUEHWVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264195AbUEHWVu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 18:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264101AbUEHWVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 18:21:50 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:54283 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264195AbUEHWVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 18:21:49 -0400
Date: Sat, 8 May 2004 23:21:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rmap 24 no rmap fastcalls
Message-ID: <20040508232143.A12293@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0405082250570.26569-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0405082250570.26569-100000@localhost.localdomain>; from hugh@veritas.com on Sat, May 08, 2004 at 10:55:22PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  	/*
> -	 * The warning below may appear if page_referenced catches the
> -	 * page in between page_add_{anon,file}_rmap and its replacement
> +	 * The warning below may appear if page_referenced_anon catches
> +	 * the page in between page_add_anon_rmap and its replacement

is this backing out of my comment fixup intentional? :)

