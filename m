Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267421AbUG2CXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267421AbUG2CXe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 22:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267422AbUG2CXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 22:23:33 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:11732 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267421AbUG2CWx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 22:22:53 -0400
Date: Wed, 28 Jul 2004 19:22:52 -0700
From: Paul Jackson <pj@sgi.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: davem@redhat.com, peter@chubb.wattle.id.au,
       viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: stat very inefficient
Message-Id: <20040728192252.42a078a3.pj@sgi.com>
In-Reply-To: <41084DBE.1070802@redhat.com>
References: <233602095@toto.iv>
	<16648.10711.200049.616183@wombat.chubb.wattle.id.au>
	<20040728154523.20713ef1.davem@redhat.com>
	<41084DBE.1070802@redhat.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Check your strace output to see whether your system is recent enough.

The latest findutils package I can find is version 4.1.20, and its most
recent ChangeLog entry is dated 2001-06-09.

It doesn't have this feature of find not stat'ing the regular files, but
using dirent d_type instead.

I also found a March 2004 thread presenting a patch to use d_type, at:

  http://lists.gnu.org/archive/html/bug-findutils/2004-03/msg00004.html

But the thread seemed to end inconclusively, after just a few messages
discussing various alternative implementations of some stuff.

Ulrich - could you provide a clue where to find a find that does what
you describe?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
