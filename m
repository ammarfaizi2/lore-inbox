Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266888AbUH3GHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266888AbUH3GHy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 02:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267330AbUH3GHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 02:07:54 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:23982 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S266888AbUH3GHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 02:07:51 -0400
Date: Mon, 30 Aug 2004 02:08:02 -0400
To: linux-kernel@vger.kernel.org
Subject: Proper licensing for binary-only firmware
Message-ID: <20040830060802.GA3196@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
From: neroden@fastmail.fm (Nathanael Nerode)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has nothing to do with whether binary firmware is "linked" to the kernel
or any such stuff; it's strictly about whether it can be publicly
distributed at all.  So please don't react before you actually read it.

Licensing of sourceless binary microcode in the kernel falls into the
following categories:
(1) Not explicitly licensed for distribution:
  Can't legally be distributed unless it isn't subject to copyright.
  (short constants, etc. obviously aren't copyrightable -- 1K blocks of
  non-repetative machine code clearly are).  Can everyone
  agree that unlicenced copyrightable material doesn't belong in the kernel
  and exposes all distributors to lawsuits?
(2) Licensed under BSD/MIT/other license which doesn't require source code
  These can clearly be distributed safely.
(3) Supposedly licensed under the GPL.
  OK.  The GPL basically doesn't allow distribution without source (or a three
  year offer of source, etc.).  So what am I supposed to make of a
  binary-only, sourceless lump of code which claims to be licensed only
  under the GPL?  :-P  Legally speaking, that doesn't seem like it gives me
  a valid license to distribute.  Which sucks, and worries me.

  (If you're going to argue that hex strings in a C file are the source code,
  recall that source code is defined by the GPL as "preferred form for
  modification".  It doesn't seem reasonable to assume that that is actually
  the preferred form for modification of a large lump of code.  If
  that's seriously the preferred form for modification, I would not be
  comfortable unless the copyright holder said so explicitly.  Am I wrong
  here?)

  However, the copyright holders probably intended to give a license to
  distribute.  So they should be willing to allow the sourceless binaries to
  be distributed/modified/etc.  They just didn't actually issue a license
  which clearly *does* so.

  How can we help them to issue a license which correspond to their intention?
  I can think of several ways:
  * Ask them to grant a special exception to the GPL to allow the binaries
  to be distributed/modified without source
  * Ask them to provide the source (even if it's not buildable with free
  tools, that would appear to satisfy the GPL)
  * Ask them to license under BSD/MIT/etc.
  * Ask them to say that the hex strings really, honestly, are the way
  they prefer to modify the microcode

Do people think that it's reasonable to consider licensing of (creative,
subject to copyright) sourceless binary lumps under the "GPL" as a clear
distributability problem, and a bug which should be fixed?  Or does someone
have a legal reference which says we don't have to worry at all?  Basically,
I'm worried about legal exposure here.

-- 
This space intentionally left blank.
