Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbUJWWRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUJWWRA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 18:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbUJWWRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 18:17:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35501 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261321AbUJWWQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 18:16:57 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, Matt Mackall <mpm@selenic.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The naming wars continue...
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
	<20041022234631.GF28904@waste.org>
	<20041023011549.GK17038@holomorphy.com>
	<Pine.LNX.4.58.0410221821030.2101@ppc970.osdl.org>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 23 Oct 2004 19:16:35 -0300
In-Reply-To: <Pine.LNX.4.58.0410221821030.2101@ppc970.osdl.org>
Message-ID: <orlldxnkqk.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 22, 2004, Linus Torvalds <torvalds@osdl.org> wrote:

> However, for some reason four numbers just looks visually too obnoxious to
> me, so as I don't care that much, I'll just use "-rc", and we can all
> agree that it stands for "Ridiculous Count" rather than "Release
> Candidate".

Naah...  That's too boring.

I think we should have several different annotations, to denote how
stable the tarball is supposed to be, and how close we are to a final
release.  Say:

Raw Code, or Revamp & Catch-up: the sort of thing you'd get right
after the huge number of changesets we saw go in right after 2.6.9.
Depending on whether it contains mostly incremental changes or major
rework of internals, you'd go with the former or the latter.

Really Churning: more of the same, but not with such a big back-log
from waiting for the previous release.

Rapidly Changing: still accepting a large number of patches, fixing
bugs, adding features, whatever, but not as much of a dump of
never-tested-together patches as Raw Code tarballs.

Run with Care: sort of the same as above, but used to explicitly mark
tarballs in which patches that add significant risk of introducing
memory, disk or government corruption.

Ready or Close: as we approach a stable release, we stop merging new
features, and focus on installing only serious bug fixes.

Release Cuality: if it works, it becomes the final release.  No known
bugs, except for typos ;-)

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
