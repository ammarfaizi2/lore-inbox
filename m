Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbUEJWGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbUEJWGS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 18:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbUEJWGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 18:06:04 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:41744 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261638AbUEJWF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 18:05:59 -0400
Date: Mon, 10 May 2004 23:05:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-ID: <20040510230558.A8159@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040510024506.1a9023b6.akpm@osdl.org> <20040510223755.A7773@infradead.org> <20040510150203.3257ccac.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040510150203.3257ccac.akpm@osdl.org>; from akpm@osdl.org on Mon, May 10, 2004 at 03:02:03PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Capabilities are broken and don't work.  Nobody has a clue how to provide
> the required services with SELinux and nobody has any code and we need the
> feature *now* before vendors go shipping even more ghastly stuff.

The thing is special privilegues for a group don't fit into any of the
various privilegues schemes we have (capabilities, selinux, etc..),
it's really a horrible hack.  What happened to the patch rick promised
to make mlock an rlimit?  This is the right approach and could be easily
extended to hugetlb pages.

