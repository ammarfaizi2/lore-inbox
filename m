Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262259AbVF1Xng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbVF1Xng (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 19:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbVF1Xm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 19:42:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50112 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262259AbVF1XJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:09:38 -0400
Date: Tue, 28 Jun 2005 16:09:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: khali@linux-fr.org, chrisw@osdl.org, linux-kernel@vger.kernel.org,
       stable@kernel.org, tytso@mit.edu, zwane@arm.linux.org.uk,
       jmforbes@linuxtx.org, rdunlap@xenotime.net, torvalds@osdl.org,
       chuckw@quantumlinux.com, alan@lxorguk.ukuu.org.uk,
       andrew.vasquez@qlogic.com, James.Bottomley@SteelEye.com
Subject: Re: [02/07] [SCSI] qla2xxx: Pull-down scsi-host-addition to follow
 board initialization.
Message-Id: <20050628160931.0e7d6b41.akpm@osdl.org>
In-Reply-To: <20050628223012.GG9046@shell0.pdx.osdl.net>
References: <20050627224651.GI9046@shell0.pdx.osdl.net>
	<20050627225349.GK9046@shell0.pdx.osdl.net>
	<20050628235148.4512d046.khali@linux-fr.org>
	<20050628152037.690c3840.akpm@osdl.org>
	<20050628223012.GG9046@shell0.pdx.osdl.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:
>
> * Andrew Morton (akpm@osdl.org) wrote:
> > The threshold for "what belongs in -stable" is a) set too high and b)
> > over-zealously enforced.
> 
> Do you have things you'd like to see in -stable that didn't make the
> cut?

Nope - I'm just making vague unsubstantiated accusations ;)

<general handwaving> Given the number of bugs which are present in each
release (as evidenced by the amount of stuff we're fixing), there's a hell
of a lot of material which _could_ go into -stable.

I suspect some things are slipping through.  It's a big job though.

I didn't help much in 2.6.11.x and am paying more attention this time,
mainly by being more vigilant looking at the commits list.

2.6.11.x was the first time and things are still getting underway.
