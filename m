Return-Path: <linux-kernel-owner+w=401wt.eu-S936378AbWLIOja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936378AbWLIOja (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 09:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936383AbWLIOja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 09:39:30 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:49683 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936378AbWLIOj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 09:39:29 -0500
X-Originating-Ip: 74.102.209.62
Date: Sat, 9 Dec 2006 09:35:40 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Re: Re: [PATCH] kcalloc: Re-order the first two out-of-order
 args to kcalloc().
In-Reply-To: <84144f020612090631ob345faah336460b64955ee14@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0612090933410.14564@localhost.localdomain>
References: <Pine.LNX.4.64.0612081837020.6610@localhost.localdomain> 
 <84144f020612090553n7fe309b7u54dd7f58424c4008@mail.gmail.com> 
 <Pine.LNX.4.64.0612090855590.14206@localhost.localdomain> 
 <84144f020612090613s28aeb485ua7c652393cff3f90@mail.gmail.com> 
 <Pine.LNX.4.64.0612090913210.14456@localhost.localdomain>
 <84144f020612090631ob345faah336460b64955ee14@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2006, Pekka Enberg wrote:

> On 12/9/06, Robert P. J. Day <rpjday@mindspring.com> wrote:
> > no.  those two submissions represent two logically different "fixes"
> > and i have no intention of combining them.
>
> Like I said, fixing the order of kcalloc parameters with a follow-up
> patch to use kzalloc is just plain stupid. You can ignore my review
> comments all you want, but don't expect that bit to be merged. So,
> for the record: NAK for that bit of the patch, it should be
> converted to kzalloc instead. Thanks.

all right.  but it will be amusing if the resulting patch is rejected
because it combines two different fixes, won't it?  :-)

rday
