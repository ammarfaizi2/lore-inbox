Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbVBII6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVBII6n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 03:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVBII6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 03:58:42 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:8070 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261742AbVBII6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 03:58:38 -0500
To: Kevin Puetz <puetzk@puetzk.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
References: <20050202155403.GE3117@crusoe.alcove-fr>
	<51cfdfdc084037ae1e3f164b0c524abc@libero.it>
	<20050203104501.GC3144@crusoe.alcove-fr>
	<87sm4cm4io.fsf@goat.bogus.local> <cuc6el$7r5$2@sea.gmane.org>
From: Miles Bader <miles@lsi.nec.co.jp>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
Date: Wed, 09 Feb 2005 17:58:22 +0900
In-Reply-To: <cuc6el$7r5$2@sea.gmane.org> (Kevin Puetz's message of "Tue, 08
 Feb 2005 23:19:43 -0600")
Message-ID: <buowtticdox.fsf@mctpc71.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Puetz <puetzk@puetzk.org> writes:
>> If you use svk <http://svk.elixus.org/> for the client side, there's
>> (almost?) no overhead.
>> 
>> Regards, Olaf.
>
> erm, svk is cool and all, but it keeps a local repository mirror (not
> necessarily full I suppose, but usually it is). So it's *much* heavier on
> the client side than normal svn. Pays off in several ways, but just because
> it keeps it's weight in the depot folder instead of the wc folder doesn't
> make it ligher (unless you use several wc's I suppose).

Hmmm, I thought that several other systems had similar (or worse)
overhead -- most notably that bk and darcs have no real notion of a
"repository", but always store the entire history in every source tree.
Such a model seems to simplify the user interface in some cases, but
obviously can impact disk usage...

However I have no real experience with either bk or darcs; please
correct me if I'm wrong about this.

[This is as opposed to arch, which has a repository (local/remote)
model, and allows even repositories to contain only deltas from some
other repository.]

-Miles
-- 
Yo mama's so fat when she gets on an elevator it HAS to go down.
