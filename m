Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWCIRd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWCIRd0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 12:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWCIRd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 12:33:26 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:21080 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750981AbWCIRdZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 12:33:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n+aL+62u4y69a8nh1T6cIv5esyLTbE6t24FShHZHd9Ym00xoWnwZ7V9TnAdQhMOGE3SF9nLGmYXQy2wyjgspmo7Sio6JezGtj2l1vRegnCLu/QKDOMpFce2kKDAkLCMi827VjKxtK4txsWNTbqSqIQINbOz9kgJk6l+tuXx6Eho=
Message-ID: <161717d50603090933o3df190f9vb1e06b0ec37deb8e@mail.gmail.com>
Date: Thu, 9 Mar 2006 12:33:24 -0500
From: "Dave Neuer" <mr.fred.smoothie@pobox.com>
To: "Phillip Susi" <psusi@cfl.rr.com>
Subject: Re: [future of drivers?] a proposal for binary drivers.
Cc: Luke-Jr <luke@dashjr.org>, "Anshuman Gholap" <anshu.pg@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <441057D4.6030304@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <ec92bc30603080135j5257c992k2452f64752d38abd@mail.gmail.com>
	 <200603091509.06173.luke@dashjr.org> <441057D4.6030304@cfl.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/06, Phillip Susi <psusi@cfl.rr.com> wrote:
> Luke-Jr wrote:
> > Or Linux can remain GPL'd, which prohibits binary drivers *legally*, and back
> > this by keeping a non-stable API which prohibits binary drivers
> > *technically*.
>
> If binary drivers are illegal, then why have ATI and nvidia not been
> sued yet?

Because no sufficiently deep-pocketed plaintiff has chosen to do so
yet. Don't incorrectly infer anything about the existence of a cause
of action from a lack of legal proceedings so far.

>
> Interacting with the kernel does not make your software a derived work.

That may or may not be true, depending on the nature of the
interaction, and the arbiter of truth in this case is the court
system, not you or I.

>  A derived work is if you make your own kernel that is very close to a
> straight copy of the Linux kernel.  The right to create new works that
> interact with others ( and therefore, require some understanding of how
> the other work operates ) is specifically protected by the US copyright
> act.

There are no dearth of legal opinions on this matter which differ
quite radically from your interpretation here, quite a few from
lawyers. As far as I am concerned (and the GPL too, if my
interpretation of it is correct), any code is a derived work of my
code if either a) it directly makes use of symbols in my code or b) it
cannot execute unless my code executes, such that its distribution
without my code would be useless.

>
> This is why it is legal to reverse engineer a binary driver to gain an
> understanding of how the hardware operates, publish that information,
> and then use that information to create new software to operate that
> hardware.

No, you are referring to a restriction on the limitations in software
licenses which is separate from copyright. Copyright law does not talk
about interoperability at all. And even the applicability of the
restriction to which you refer is jurisdiction-dependant as well as
context-dependant (see the DMCA).

Regards,
Dave
