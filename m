Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275374AbTHNTDm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 15:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275376AbTHNTDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 15:03:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:55493 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275374AbTHNTDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 15:03:40 -0400
Date: Thu, 14 Aug 2003 11:59:37 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Philip Brown <phil@bolthole.com>
Cc: dri-devel@lists.sourceforge.net, lm@work.bitmover.com, eli.carter@inet.com,
       lm@bitmover.com, jgarzik@pobox.com, davej@redhat.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Dri-devel] Re: [PATCH] CodingStyle fixes for drm_agpsupport
Message-Id: <20030814115937.52950201.rddunlap@osdl.org>
In-Reply-To: <20030814114340.A48492@bolthole.com>
References: <E19mF4Y-0005Eg-00@tetrachloride>
	<20030811164012.GB858@work.bitmover.com>
	<3F37CB44.5000307@pobox.com>
	<20030811170425.GA4418@work.bitmover.com>
	<3F3B9AF8.4060904@inet.com>
	<20030814144711.GA5926@work.bitmover.com>
	<20030814114340.A48492@bolthole.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Aug 2003 11:43:40 -0700 Philip Brown <phil@bolthole.com> wrote:

| On Thu, Aug 14, 2003 at 07:47:11AM -0700, Larry McVoy wrote:
| > ...
| > Indeed I have.  And there is a reason that we have a policy at BitMover
| > where "formatting changes" are prohibited and we make people redo their
| > changesets until they get them right.
| > 
| > In other words, you are welcome to write a revision control system
| > which can look through the formatting changes and give you the semantic
| > knowledge that you want.  We'd love to see how it is done and then do
| > it in BitKeeper :)
| 
| 
| You should allow for changes that are "formatting change only", with no
| actual code structural change.
| You could pass the results through stage 1 of gcc, and only allow it if the
| parsing tree is identical.
| 
| I was originally going to suggest just passing it through "indent", but
| that would not come out right, if someone added braces to clarify a
| one-line conditional.

I don't think that BK should know/recognize format-only changes.
However, it would be nice when using bk revtool, one could be looking
at a few targeted lines of a changeset and then click [Prev Rev][Next Rev]
and see the same lines in previous/next revisions of the file.
And if it already does this, great.  How do I do that?
I know how to left-click rev-A and right-click rev-B to see changes
between them, but then I have to search thru potentially several 100
or 1000 lines of code for the 10 lines that I'm looking for.
(and it would be nice if one could choose to have the lines numbered).

--
~Randy   [who thinks this should be on bk-users]
