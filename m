Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVCCI2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVCCI2i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 03:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVCCI2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 03:28:38 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:9636 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S261616AbVCCI2Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 03:28:24 -0500
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <42265A6F.8030609@pobox.com>
	<20050302165830.0a74b85c.davem@davemloft.net>
	<422674A4.9080209@pobox.com>
	<Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
	<42268749.4010504@pobox.com>
	<20050302200214.3e4f0015.davem@davemloft.net>
	<42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com>
	<20050302205826.523b9144.davem@davemloft.net>
	<4226C235.1070609@pobox.com> <20050303080459.GA29235@kroah.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 03 Mar 2005 03:28:22 -0500
In-Reply-To: <20050303080459.GA29235@kroah.com>
Message-ID: <yq0y8d5dtg9.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Greg" == Greg KH <greg@kroah.com> writes:

Greg> On Thu, Mar 03, 2005 at 02:52:21AM -0500, Jeff Garzik wrote:
>> Users have been clamoring for a stable release branch in any case,
>> as you see from comments about Alan's -ac and an LKML user's -as
>> kernels.

Greg> Sure they've been asking for it, but I think they really don't
Greg> know what it entails.  Look at all of the "non-stable" type
Greg> patches in the -ac and as tree.  There's a lot of stuff in
Greg> there.  It's a slippery slope down when trying to say, "I'm only
Greg> going to accept bug fixes."

Greg> Bug fixes for what?  Kernel api changes that fix bugs?  That's
Greg> pretty big.  Some driver fixes, but not others?  Driver fixes
Greg> that are in the middle of bigger, subsystem reworks as a series
Greg> of patches?  All of this currently happens today in the main
Greg> tree in a semi-cohesive manner.  To try to split it out is a
Greg> very difficult task.

Greg> So, while I like the _idea_ of the 2.6.x.y type releases, having
Greg> those releases contain anything but a handful of patches will
Greg> quickly get quite messy.

Greg,

Wouldn't this actually happen automatically simply by Linus switching
to being a lot more picky about whats accepted into an even release. I
agree that if it becomes too formal it could probably turn into an
unmaintainable mess. However, by simply making it a golden rule, then
developers can just continue pushing their patches and the people
above can just shift things to -mm that aren't deemed suitable for the
even release.

I think this would work quite well.

Cheers,
Jes
