Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270707AbTHAKlz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 06:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270712AbTHAKlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 06:41:55 -0400
Received: from AMarseille-201-1-1-232.w193-252.abo.wanadoo.fr ([193.252.38.232]:51239
	"EHLO gaston") by vger.kernel.org with ESMTP id S270707AbTHAKly
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 06:41:54 -0400
Subject: Re: mremap sleeping in incorrect context
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030731145132.64ab1574.akpm@osdl.org>
References: <1059586337.2420.44.camel@gaston>
	 <20030730153439.7df44a69.akpm@osdl.org> <1059658728.2417.112.camel@gaston>
	 <20030731145132.64ab1574.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059734484.8194.45.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 01 Aug 2003 12:41:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-31 at 23:51, Andrew Morton wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > 
> > > oops.  What are your CONFIG_HIGHMEM and CONFIG_HIGHPTE settings there?
> > 
> > this is on ppc32, HIGHPTE doesn't exist, HIGHMEM is enabled (1Gb of
> > RAM)
> > 
> 
> OK, thanks.  Seems that I made a little bug.  This should fix it.  With a
> changelog like this, it _has_ to be right ;)

Thanks, I'll apply here and let you know if this warning is really gone
after a couple of days of use...

Ben.

