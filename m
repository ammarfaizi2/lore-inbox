Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVGKOCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVGKOCo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 10:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVGKOAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 10:00:35 -0400
Received: from mail.sanpeople.com ([196.41.13.122]:9733 "EHLO
	za-gw.sanpeople.com") by vger.kernel.org with ESMTP id S261703AbVGKN6n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 09:58:43 -0400
Subject: Re: [RFC] Atmel-supplied hardware headers for AT91RM9200 SoC
	processor
From: Andrew Victor <andrew@sanpeople.com>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Russell King <rmk@arm.linux.org.uk>,
       alan@lxorguk.ukuu.org.uk, dwmw2@infradead.org
In-Reply-To: <1121088922.7407.64.camel@localhost.localdomain>
References: <1120730318.16806.75.camel@fuzzie.sanpeople.com>
	 <20050707130607.GC28489@infradead.org>
	 <1121088922.7407.64.camel@localhost.localdomain>
Content-Type: text/plain
Organization: SAN People (Pty) Ltd
Message-Id: <1121090246.7380.46.camel@fuzzie.sanpeople.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Jul 2005 15:57:26 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

> > No reason to use the horror it is as-is.  Beein hardware description they
> > won't change ever except for additions, so just clean the mess up into
> > somethign nice and submit them.  You could have done so in the time you
> > spent arguing on linux-arm-kernel already.
> 
> Or written a perl script to reprocess them into something saner for
> that matter.

The issue that everybody seems to be forgetting (or ignoring) with
changing the headers is that ALL the drivers then also need to be
converted, and re-tested.


> The licensing does look problematic - perhaps Atmel will be happy to
> dual license them (see the many BSD bits of code that are in kernel
> and say things like "or at your option you may use the GNU Public
> License version 2 or later" and similar.

I have asked Atmel if they're willing to dual-license the headers.  The
licensing issue is probably now with their legal department, but I don't
see them having a problem with it.


Regards,
  Andrew Victor


