Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264101AbUEHWfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264101AbUEHWfn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 18:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUEHWfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 18:35:43 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:60683 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264101AbUEHWfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 18:35:38 -0400
Date: Sat, 8 May 2004 23:35:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rmap 24 no rmap fastcalls
Message-ID: <20040508233535.A12415@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
References: <20040508232143.A12293@infradead.org> <Pine.LNX.4.44.0405082327420.26646-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0405082327420.26646-100000@localhost.localdomain>; from hugh@veritas.com on Sat, May 08, 2004 at 11:32:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2004 at 11:32:26PM +0100, Hugh Dickins wrote:
> I wouldn't dare!  No, look again, it doesn't back it out, it refines
> it to refer solely to page_add_anon_rmap, page_add_file_rmap is not
> relevant here - your fixup was that the original comment still said
> page_add_rmap after that had been replaced by anon, file variants.

ah, thanks!

