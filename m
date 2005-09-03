Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbVICMcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbVICMcm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 08:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbVICMcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 08:32:42 -0400
Received: from blackbird.sr71.net ([64.146.134.44]:53959 "EHLO
	blackbird.sr71.net") by vger.kernel.org with ESMTP id S1751056AbVICMcm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 08:32:42 -0400
Subject: Re: [RFC] broken installkernel.sh with CROSS_COMPILE
From: Dave Hansen <dave@sr71.net>
To: Ian Campbell <icampbell@arcom.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PPC64 External List <linuxppc64-dev@ozlabs.org>
In-Reply-To: <1125737431.6565.88.camel@azathoth.hellion.org.uk>
References: <1125693554.26605.10.camel@localhost>
	 <1125737431.6565.88.camel@azathoth.hellion.org.uk>
Content-Type: text/plain
Date: Sat, 03 Sep 2005 05:31:57 -0700
Message-Id: <1125750717.11083.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-09-03 at 09:50 +0100, Ian Campbell wrote:
> > Could we do something that's guaranteed to not have lots of extra
> path
> > elements in it, like ARCH?
> 
> Or perhaps basename ${CROSSCOMPILE}?

The only problem with that is that some people do really have a cross
compiler named /usr/ppc64/bin/gcc.  So, basename will just give you
something useless like "bin".

-- Dave

