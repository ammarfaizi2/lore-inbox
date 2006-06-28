Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWF1QNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWF1QNi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 12:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWF1QNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:13:38 -0400
Received: from styx.suse.cz ([82.119.242.94]:58583 "EHLO elijah.suse.cz")
	by vger.kernel.org with ESMTP id S1751327AbWF1QNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:13:37 -0400
Subject: Re: Kernel API Reference Documentation
From: Petr Tesarik <ptesarik@suse.cz>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Lukas Jelinek <info@kernel-api.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060628090950.c1862a9e.rdunlap@xenotime.net>
References: <44A1858B.9080102@kernel-api.org>
	 <1151495225.8127.68.camel@elijah.suse.cz> <44A2749D.7030705@kernel-api.org>
	 <20060628090950.c1862a9e.rdunlap@xenotime.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: SuSE CR
Date: Wed, 28 Jun 2006 18:13:35 +0200
Message-Id: <1151511215.8127.74.camel@elijah.suse.cz>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-28 at 09:09 -0700, Randy.Dunlap wrote:
> On Wed, 28 Jun 2006 14:22:53 +0200 Lukas Jelinek wrote:
> 
> > > I looked at
> > > http://www.kernel-api.org/docs/online/2.6.17/da/dab/structsk__buff.html
> > > 
> > > and you apparently ignore kernel-doc for structs. Cf.
> > > include/linux/skbuff.h:177 ff.
> > 
> > There are several problems. The one you describe is probably caused by a
> > blank line between the struct and the related comment. Doxygen doesn't
> > recognize it correctly (and simply ignores the comment).
> 
> No blank line in this case.

Oh, yes, there is a blank line between the comment and the struct. It's
a pitty that someone put much effort into writing a usable description,
which is then not seen. Anyway, should we find all such occurences in
the kernel tree and fix them, or make a workaround for doxygen?

Regards,
Petr
