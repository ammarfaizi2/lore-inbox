Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262200AbVFWGIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbVFWGIa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 02:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbVFWGIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 02:08:30 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:25993 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262151AbVFWGIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:08:23 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Adam Kropelin <akropel1@rochester.rr.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
References: <42B9E536.60704@pobox.com>
	<Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org>
	<42BA18AF.2070406@pobox.com>
	<Pine.LNX.4.58.0506221915280.11175@ppc970.osdl.org>
	<07be01c577a7$05108660$03c8a8c0@kroptech.com>
	<Pine.LNX.4.58.0506222146460.11175@ppc970.osdl.org>
From: Miles Bader <miles@lsi.nec.co.jp>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
Date: Thu, 23 Jun 2005 15:07:55 +0900
In-Reply-To: <Pine.LNX.4.58.0506222146460.11175@ppc970.osdl.org> (Linus Torvalds's message of "Wed, 22 Jun 2005 21:54:23 -0700 (PDT)")
Message-Id: <buofyv9wqpw.fsf@mctpc71.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:
> And if you have more than a few files dirty in your tree, I really think
> it's much better to do "git status" and think about it a bit and select
> the files you do want to commit than it is to just do "git commit" and let
> it rip.
>
> Now, I could well imagine adding an "--all" flag (and not even allow the 
> shorthane version) to both git-update-cache and "git commit". So that you 
> could say "commit all the dirty state", but you'd at least have to think 
> about it before you did so.

I think both modes of operation are useful -- sometimes I want to hack
in the tree and later decide what to commit, and sometimes I know
exactly what sequence of commits I want to make and do a series of
"change-some-files then commit everything" steps.

In the latter case, it's very convenient to have commit just grab
everything and clear the slate for my next step.  Morever, I use the
latter style enough that I think even the requirement of a long option
seems annoying and artificial; a short option would be fine though...

-Miles
-- 
Any man who is a triangle, has thee right, when in Cartesian Space, to
have angles, which when summed, come to know more, nor no less, than
nine score degrees, should he so wish.  [TEMPLE OV THEE LEMUR]
