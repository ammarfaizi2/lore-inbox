Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbVBINsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVBINsQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 08:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVBINsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 08:48:16 -0500
Received: from user-10mt71s.cable.mindspring.com ([65.110.156.60]:24105 "EHLO
	localhost") by vger.kernel.org with ESMTP id S261820AbVBINsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 08:48:13 -0500
Date: Wed, 9 Feb 2005 08:44:16 -0500
From: David Roundy <droundy@abridgegame.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
Message-ID: <20050209134411.GC6881@abridgegame.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050202155403.GE3117@crusoe.alcove-fr> <51cfdfdc084037ae1e3f164b0c524abc@libero.it> <20050203104501.GC3144@crusoe.alcove-fr> <87sm4cm4io.fsf@goat.bogus.local> <cuc6el$7r5$2@sea.gmane.org> <buowtticdox.fsf@mctpc71.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <buowtticdox.fsf@mctpc71.ucom.lsi.nec.co.jp>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2005 at 05:58:22PM +0900, Miles Bader wrote:
> Kevin Puetz <puetzk@puetzk.org> writes:
> > erm, svk is cool and all, but it keeps a local repository mirror (not
> > necessarily full I suppose, but usually it is). So it's *much* heavier
> > on the client side than normal svn. Pays off in several ways, but just
> > because it keeps it's weight in the depot folder instead of the wc
> > folder doesn't make it ligher (unless you use several wc's I suppose).
> 
> Hmmm, I thought that several other systems had similar (or worse)
> overhead -- most notably that bk and darcs have no real notion of a
> "repository", but always store the entire history in every source tree.
> Such a model seems to simplify the user interface in some cases, but
> obviously can impact disk usage...
> 
> However I have no real experience with either bk or darcs; please
> correct me if I'm wrong about this.

wrt darcs, you're mostly correct.  There is the possibility of a "partial"
repository, which doesn't have the full history, but that isn't the
default, and therefore tends to be less well-debugged.  On the other hand,
if you never try to *look* at the history, you're pretty much safe--the
bugs tend to show up when you try to browse that history which you *do*
have.
-- 
David Roundy
http://www.darcs.net
