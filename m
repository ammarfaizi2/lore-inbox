Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275343AbTHNSnv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 14:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275345AbTHNSnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 14:43:51 -0400
Received: from bolthole.com ([192.220.72.215]:59403 "HELO bolthole.com")
	by vger.kernel.org with SMTP id S275343AbTHNSnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 14:43:43 -0400
Date: Thu, 14 Aug 2003 11:43:40 -0700
From: Philip Brown <phil@bolthole.com>
To: dri-devel@lists.sourceforge.net
Cc: Larry McVoy <lm@work.bitmover.com>, Eli Carter <eli.carter@inet.com>,
       Larry McVoy <lm@bitmover.com>, Jeff Garzik <jgarzik@pobox.com>,
       davej@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Dri-devel] Re: [PATCH] CodingStyle fixes for drm_agpsupport
Message-ID: <20030814114340.A48492@bolthole.com>
Reply-To: Philip Brown <phil@bolthole.com>
Mail-Followup-To: dri-devel@lists.sourceforge.net,
	Larry McVoy <lm@work.bitmover.com>,
	Eli Carter <eli.carter@inet.com>, Larry McVoy <lm@bitmover.com>,
	Jeff Garzik <jgarzik@pobox.com>, davej@redhat.com,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <E19mF4Y-0005Eg-00@tetrachloride> <20030811164012.GB858@work.bitmover.com> <3F37CB44.5000307@pobox.com> <20030811170425.GA4418@work.bitmover.com> <3F3B9AF8.4060904@inet.com> <20030814144711.GA5926@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030814144711.GA5926@work.bitmover.com>; from lm@bitmover.com on Thu, Aug 14, 2003 at 07:47:11AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 07:47:11AM -0700, Larry McVoy wrote:
> ...
> Indeed I have.  And there is a reason that we have a policy at BitMover
> where "formatting changes" are prohibited and we make people redo their
> changesets until they get them right.
> 
> In other words, you are welcome to write a revision control system
> which can look through the formatting changes and give you the semantic
> knowledge that you want.  We'd love to see how it is done and then do
> it in BitKeeper :)


You should allow for changes that are "formatting change only", with no
actual code structural change.
You could pass the results through stage 1 of gcc, and only allow it if the
parsing tree is identical.

I was originally going to suggest just passing it through "indent", but
that would not come out right, if someone added braces to clarify a
one-line conditional.
