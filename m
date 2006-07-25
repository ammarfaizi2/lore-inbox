Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbWGYGb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWGYGb7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 02:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWGYGb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 02:31:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18081 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751463AbWGYGb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 02:31:57 -0400
Date: Mon, 24 Jul 2006 23:31:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, mingo@elte.hu,
       petero2@telia.com, laurent.riffard@free.fr
Subject: Re: [patch] lockdep: annotate pktcdvd natural device hierarchy
Message-Id: <20060724233131.d76a7f60.akpm@osdl.org>
In-Reply-To: <1153805684.8932.3.camel@laptopd505.fenrus.org>
References: <448875D1.5080905@free.fr>
	<448D84C0.1070400@linux.intel.com>
	<m3sllxtfbf.fsf@telia.com>
	<1151000451.3120.56.camel@laptopd505.fenrus.org>
	<m3u05kqvla.fsf@telia.com>
	<1152884770.3159.37.camel@laptopd505.fenrus.org>
	<m3odvrc2vo.fsf@telia.com>
	<1152947098.3114.9.camel@laptopd505.fenrus.org>
	<44B8C506.1000009@free.fr>
	<m3ac7b6spp.fsf@telia.com>
	<44BA1609.9050305@free.fr>
	<20060724192718.547a836e.akpm@osdl.org>
	<1153805684.8932.3.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2006 07:34:44 +0200
Arjan van de Ven <arjan@infradead.org> wrote:

> On Mon, 2006-07-24 at 19:27 -0700, Andrew Morton wrote:
> > On Sun, 16 Jul 2006 12:33:45 +0200
> 
> > Arjan, do we still need
> > lockdep-annotate-pktcdvd-natural-device-hierarchy.patch?
> 
> yes afaics
> 
> > And could you please take a look at Peter's block_dev.c changes?  Closely,
> > please - it'd be nice to get this right one of these days ;)
> 
> I'm not too happy about them; they use the partition uglies for
> something which is not a partition; the uglyness should stop not
> spread... while the patch probably is effective in shutting lockdep up
> it's not really the right approach.
> 

OK, I dropped them again.
