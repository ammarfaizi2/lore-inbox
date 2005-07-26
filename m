Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVGZB3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVGZB3i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 21:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVGZB3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 21:29:38 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:45961 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261466AbVGZB3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 21:29:34 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Vincent Hanquez <vincent.hanquez@cl.cam.ac.uk>, Andi Kleen <ak@suse.de>
Subject: Re: [patch 2.6.13-rc3] i386: clean up user_mode macros
References: <200507251901_MC3-1-A589-A433@compuserve.com>
	<Pine.LNX.4.58.0507251608430.6074@g5.osdl.org>
From: Miles Bader <miles@lsi.nec.co.jp>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
Date: Tue, 26 Jul 2005 10:28:43 +0900
In-Reply-To: <Pine.LNX.4.58.0507251608430.6074@g5.osdl.org> (Linus Torvalds's message of "Mon, 25 Jul 2005 16:13:13 -0700 (PDT)")
Message-Id: <buoll3upd84.fsf@mctpc71.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:
> Ask a hundred random C programmers what "!!x" means, versus what "x != 0"
> means, and time their replies.

I've always thought of "!!" as the "canonicalize boolean" operator...

Vaguely ugly, but I think it's actually _more clear_ than != 0 in
contexts where the value is already "boolean" in the C zero or not-zero
sense, but you want a "proper" boolean (0 or 1) for some reason.

-miles
-- 
Somebody has to do something, and it's just incredibly pathetic that it
has to be us.  -- Jerry Garcia
