Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbTEEO5U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 10:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbTEEO5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 10:57:20 -0400
Received: from adsl-66-127-195-58.dsl.snfc21.pacbell.net ([66.127.195.58]:61380
	"EHLO panda.mostang.com") by vger.kernel.org with ESMTP
	id S262298AbTEEO5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 10:57:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16054.32214.804891.702812@panda.mostang.com>
Date: Mon, 5 May 2003 08:05:58 -0700
To: Richard Henderson <rth@twiddle.net>
Cc: David Mosberger-Tang <David.Mosberger@acm.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix vsyscall unwind information
In-Reply-To: <20030505074248.GA7812@twiddle.net>
References: <20030502004014$08e2@gated-at.bofh.it>
	<20030503210015$292c@gated-at.bofh.it>
	<20030504063010$279f@gated-at.bofh.it>
	<ugade16g78.fsf@panda.mostang.com>
	<20030505074248.GA7812@twiddle.net>
X-Mailer: VM 7.03 under Emacs 21.2.1
Reply-To: David.Mosberger@acm.org
X-URL: http://www.mostang.com/~davidm/
From: davidm@mostang.com (David Mosberger-Tang)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 5 May 2003 00:42:48 -0700, Richard Henderson <rth@twiddle.net> said:

  >> If not, could one be added?

  Richard> Why?  Certainly it isn't needed for x86.

Certain applications (such as debuggers) want to know.  Sure, you can
do symbol matching (if you have the symbol table) or code-reading
(assuming you know the exact sigreturn sequence), but having a marker
would be more reliable and faster.

	--david
