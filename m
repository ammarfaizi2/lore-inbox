Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264198AbTEWXRC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 19:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264200AbTEWXRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 19:17:02 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:6148 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264198AbTEWXRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 19:17:01 -0400
Subject: RE: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
From: James Bottomley <James.Bottomley@steeleye.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 23 May 2003 19:29:53 -0400
Message-Id: <1053732598.1951.13.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    although I respect your maintainer's responsible and safe position, I'd like
    to state that version 6.2.28 has been in the latest pre-releases for quite some
    time, and the reason you invoked for removing it at -rc time was the lockups
    people still encounter with the version present in -rc3, perhaps to a lesser
    extent. These lockups *SEEM* to have vanished from 6.2.33 for people who
    complained previously. Moreover, the lockup I encountered on my systems was
    fixed and demonstrated by Justin to really be a locking bug, so this was not
    just a "let's see how it behaves" fix.
    
I think there's some misunderstanding about what a release candidate
is.  It's an attempt to see if a particular set of code is viable as the
released product.  Any bugs reported against a rc that are deemed
problems to the release need to be fixed, either by adding a simple and
easily verifiable bug fix or by reverting the problem code.

The bksend file on http://people.freebsd.org/~gibbs/linux/SRC/
representing the requested updates is 475k compressed.  There's no
definition of the phrase "simple and easily verifiable bug fix" I can
encompass that could be applied to a chunk of code that size.

In these circumstances, absent a simple fix for the problem, the only
choice seems to be reversion and trying to get the code base stable at
the beginning of the next -pre, which is the current decision.

James


