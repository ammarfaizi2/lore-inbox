Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315414AbSGYRIO>; Thu, 25 Jul 2002 13:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315416AbSGYRIN>; Thu, 25 Jul 2002 13:08:13 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:25098 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315414AbSGYRIN>; Thu, 25 Jul 2002 13:08:13 -0400
Date: Thu, 25 Jul 2002 18:11:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Cort Dougan <cort@fsmlabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cheap lookup of symbol names on oops()
Message-ID: <20020725181126.A17859@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Cort Dougan <cort@fsmlabs.com>, linux-kernel@vger.kernel.org
References: <20020725110033.G2276@host110.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020725110033.G2276@host110.fsmlabs.com>; from cort@fsmlabs.com on Thu, Jul 25, 2002 at 11:00:33AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 11:00:33AM -0600, Cort Dougan wrote:
> This is from the -atp (Aunt Tillie and Penelope) tree.
> 
> This patch adds a small function that looks up symbol names that correspond
> to given addresses by digging through the already existent ksyms table.
> It's invaluable for debugging on embedded systems - especially when testing
> modules - since ksymoops is a hassle to deal with in cross-build
> environments.  We already have this info in the kernel so we might as well
> use it.
> 
> This patch adds use of the function for PPC and i386.

Wow! very usefull patch.  O want it for 2.4 and 2.5, please.

But could you please fix up the indentation to match common kernel style?

