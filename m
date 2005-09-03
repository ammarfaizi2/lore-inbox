Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbVICOf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVICOf6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 10:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbVICOf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 10:35:58 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:19371 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750708AbVICOf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 10:35:57 -0400
Subject: Re: [RFC] broken installkernel.sh with CROSS_COMPILE
From: Ian Campbell <icampbell@arcom.com>
To: Dave Hansen <dave@sr71.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PPC64 External List <linuxppc64-dev@ozlabs.org>
In-Reply-To: <1125750717.11083.2.camel@localhost>
References: <1125693554.26605.10.camel@localhost>
	 <1125737431.6565.88.camel@azathoth.hellion.org.uk>
	 <1125750717.11083.2.camel@localhost>
Content-Type: text/plain
Organization: Arcom Control Systems Ltd.
Date: Sat, 03 Sep 2005 15:35:51 +0100
Message-Id: <1125758151.6565.90.camel@azathoth.hellion.org.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-09-03 at 05:31 -0700, Dave Hansen wrote:
> On Sat, 2005-09-03 at 09:50 +0100, Ian Campbell wrote:
> > > Could we do something that's guaranteed to not have lots of extra
> > path
> > > elements in it, like ARCH?
> > 
> > Or perhaps basename ${CROSSCOMPILE}?
> 
> The only problem with that is that some people do really have a cross
> compiler named /usr/ppc64/bin/gcc.  So, basename will just give you
> something useless like "bin".

Of course, that makes perfect sense.

Ian.
-- 
Ian Campbell

It seems to make an auto driver mad if he misses you.

