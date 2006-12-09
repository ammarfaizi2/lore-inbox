Return-Path: <linux-kernel-owner+w=401wt.eu-S1761779AbWLIOHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761779AbWLIOHO (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 09:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761781AbWLIOHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 09:07:14 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:42740 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761779AbWLIOHM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 09:07:12 -0500
X-Originating-Ip: 74.102.209.62
Date: Sat, 9 Dec 2006 09:03:27 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] kcalloc: Re-order the first two out-of-order args
 to kcalloc().
In-Reply-To: <84144f020612090554o571f142bt7f59db2c0dfa782f@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0612090901180.14206@localhost.localdomain>
References: <Pine.LNX.4.64.0612081837020.6610@localhost.localdomain> 
 <84144f020612090553n7fe309b7u54dd7f58424c4008@mail.gmail.com>
 <84144f020612090554o571f142bt7f59db2c0dfa782f@mail.gmail.com>
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

> On 12/9/06, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> > You really ought to send these cleanups to akpm@osdl.org with LKML
> > cc'd to get them merged.
>
> ...or even better, the relevant maintainer.

normally what i would do but, in the case of that patch, there are
five files affected, *all* of which are in totally different
subsystems (macintosh, net, scsi, usb, sunrpc).  are you suggesting
that up to 5 different people be CC'ed?

and what about source-wide aesthetic changes that might touch dozens
or hundreds of files?

rday
