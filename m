Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbUJ0DUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbUJ0DUI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 23:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbUJ0DUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 23:20:08 -0400
Received: from holomorphy.com ([207.189.100.168]:63466 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261617AbUJ0DT7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 23:19:59 -0400
Date: Tue, 26 Oct 2004 20:19:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Massimo Cetra <mcetra@navynet.it>
Subject: Re: My thoughts on the "new development model"
Message-ID: <20041027031946.GS15367@holomorphy.com>
References: <200410262002_MC3-1-8D38-C078@compuserve.com> <20041027003612.GM15367@holomorphy.com> <Pine.LNX.4.61.0410270342250.20284@student.dei.uc.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410270342250.20284@student.dei.uc.pt>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004, William Lee Irwin III wrote:
>> None of the bugs you cite were recently introduced.

On Wed, Oct 27, 2004 at 03:45:21AM +0100, Marcos D. Marado Torres wrote:
> Is it relevant? They exist, they must be fixed. If there is relevancy
> in this issue, the matter is "why do we care more about recently
> introduced bugs (that can be avoided by using a not-so-recent kernel)
> instead of caring about those well-known long-dated bugs?".

It is highly relevant. The argument against the development process
is on the basis of regressions introduced in subsequent versions.

When I point this out, the examples of "regressions" are invalidated,
because they are in fact not introduced or reintroduced by new releases,
and therefore not regressions at all.

Your "point", as it were, is different and incorrect on different
grounds. Waiting to fix all known bugs to issue a release will fail to
make forward progress of any kind, at the very least from "WONTFIX"
bugs, and more commonly from bugs so hard they require extended periods
of time to make progress in fixing, e.g. my current sun4d woes.

Perhaps the myth of utopias where all bugs are trivially fixable must
be dispelled. I'm not a specialist in communicating with laymen, so
my take on it is this:

Not all bugs are trivially fixable. The longstanding bugs you're
complaining about are not getting fixed because they are so hard
to fix the entire kernel programmer population of the Linux
community can't solve them in a timely fashion. They are being
worked on. We can't stop the world because of this because the
kernel is so big there are hundreds or more of these unsolved bugs
in the kernel at any given time and many of them last for years.
So we have to continue doing other things while these bugs are open.


-- wli
