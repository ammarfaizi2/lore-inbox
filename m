Return-Path: <linux-kernel-owner+w=401wt.eu-S1761161AbWLINUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761161AbWLINUx (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 08:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761150AbWLINUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 08:20:53 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:33191 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760847AbWLINUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 08:20:52 -0500
X-Originating-Ip: 74.102.209.62
Date: Sat, 9 Dec 2006 08:16:37 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Tim Schmielau <tim@physik3.uni-rostock.de>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: why are some of my patches being credited to other "authors"?
In-Reply-To: <Pine.LNX.4.63.0612091327540.24913@gockel.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.64.0612090813080.13873@localhost.localdomain>
References: <Pine.LNX.4.64.0612090515480.12992@localhost.localdomain>
 <1165663793.1103.127.camel@localhost.localdomain>
 <Pine.LNX.4.64.0612090656140.13654@localhost.localdomain>
 <Pine.LNX.4.63.0612091327540.24913@gockel.physik3.uni-rostock.de>
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

On Sat, 9 Dec 2006, Tim Schmielau wrote:

> i wrote:

> > but given that i'm trying to follow the kernel guidelines and keep
> > each submission as a logically-related chunk, in many cases, i
> > have to wait for one patch to be applied before i can submit the
> > next one. and, at the moment, there's no way of knowing what's
> > going on.
>
> Well, you can send out a patch series:
>   [patch 01/02] Prepare foo for blah
>   [patch 02/02] Apply blah to foo
> Ideally you would finish the patch description for patch 02 with something
> like
>
> ---
> This patch depends on [patch 01/02] Prepare foo for blah

... snip ...

wait a minute.  that's not what i've understood all this time as the
rationale for a multi-part patch -- to show dependency.  certainly,
that's not what you read in "SubmittingPatches":

"If one patch depends on another patch in order for a change to be
complete, that is OK.  Simply note "this patch depends on patch X" in
your patch description."

that doesn't say anything about using the multi-part notation.  are
you sure about this?

rday
