Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261809AbTC0Ido>; Thu, 27 Mar 2003 03:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261812AbTC0Ido>; Thu, 27 Mar 2003 03:33:44 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:19210 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261809AbTC0Idn>; Thu, 27 Mar 2003 03:33:43 -0500
Date: Thu, 27 Mar 2003 08:44:56 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: Re: [PATCH] s390 update (3/9): listing & kerntypes.
Message-ID: <20030327084456.A29788@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arnd Bergmann <arnd@bergmann-dalldorf.de>,
	linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
References: <20030326164014$3fac@gated-at.bofh.it> <20030326202006$09c8@gated-at.bofh.it> <200303262350.h2QNoqje015366@post.webmailer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303262350.h2QNoqje015366@post.webmailer.de>; from arnd@bergmann-dalldorf.de on Thu, Mar 27, 2003 at 12:20:07AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 12:20:07AM +0100, Arnd Bergmann wrote:
> AFAIK, s390 is the only architecture that has hardware support for taking
> system dumps without the lkcd patch. Since the lkcd patch does not
> appear to be going into mainline linux and most s390 users want the
> kerntypes anyway (every distributor includes them), arch/s390/boot
> seems to be the right place to put them.

No.  The Kerntypes patch makes lots of sense even without lkcd.  Once
again I'm all in favour of adding this patch, but adding such a generic
facility in architecture depend code is a bad idea.

