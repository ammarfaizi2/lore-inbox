Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263940AbTDGXvS (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263947AbTDGXvG (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:51:06 -0400
Received: from siaag2ad.compuserve.com ([149.174.40.134]:42119 "EHLO
	siaag2ad.compuserve.com") by vger.kernel.org with ESMTP
	id S263941AbTDGXtv (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:49:51 -0400
Date: Mon, 7 Apr 2003 19:57:49 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: BitBucket: GPL-ed KitBeeper clone
To: Petr Baudis <pasky@ucw.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304072001_MC3-1-336C-9045@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>FYI, the SVN and Arch folks have set up a mailing list
>for discussion about generic "smarter patch" format, see
>http://www.red-bean.com/mailman/listinfo/changesets for
>details/subscription.


Have you looked at Stellation at all?  I know the
code itself is Java but they have some neat ideas about
being able to take 'slices' across the repository and
treat the slice as a single file for things like revision
tracking.  In some ways this is like a changeset; I could
see wanting to track revisions this way, for example:

  1. Changeset 'fix broken ptrace' gets applied
  2. Other stuff gets changed
  3. Changeset 'fix fix broken ptrace' is applied

I would want to be able to treat 1 and 3 as a single
changeset with two revision levels.

--
 Chuck
 Today's books: Internetworking with TCP/IP - Douglas E. Comer
                Expiration Date - Tim Powers
