Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161172AbVIPRPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161172AbVIPRPQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 13:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161174AbVIPRPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 13:15:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25024 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161172AbVIPRPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 13:15:14 -0400
Date: Fri, 16 Sep 2005 18:15:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hans Reiser <reiser@namesys.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Message-ID: <20050916171509.GA32545@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <432AFB44.9060707@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432AFB44.9060707@namesys.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 10:05:08AM -0700, Hans Reiser wrote:
> All objections have now been addressed so far as I can discern.
> 
>     The VFS layering issue was addressed after 2 months of recoding.
> 
>     The undesired type safe lists were removed after ~ a man week of coding.
> 
>     Cosmetic issues regarding line length, etc., were addressed.
> 
>     Numerous ~ one line changes were made that I will not address here.
> 
>     The assertions were left in, with akpm's ok.
> 
>     Pseudo files were removed.
> 
>     dependency on !4k stacks was removed and stack usage was fixed.
> 
>     reiser4_drop_inode was removed.
> 
>     our div64_32 was replaced with the linux one

You completely ignore my last review comments.    And that was just the
errors sticking out from an half an error look.  I'll do a deeper review,
but ocfs has a higher priority right now.

