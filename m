Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbTEFGGs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 02:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbTEFGGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 02:06:47 -0400
Received: from adsl-66-127-195-58.dsl.snfc21.pacbell.net ([66.127.195.58]:480
	"EHLO panda.mostang.com") by vger.kernel.org with ESMTP
	id S261333AbTEFGGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 02:06:47 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16055.21321.863207.49015@panda.mostang.com>
Date: Mon, 5 May 2003 23:16:41 -0700
To: Richard Henderson <rth@twiddle.net>
Cc: Mark Kettenis <kettenis@chello.nl>, David.Mosberger@acm.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix vsyscall unwind information
In-Reply-To: <20030506002100.GB10921@twiddle.net>
References: <20030502004014$08e2@gated-at.bofh.it>
	<20030503210015$292c@gated-at.bofh.it>
	<20030504063010$279f@gated-at.bofh.it>
	<ugade16g78.fsf@panda.mostang.com>
	<20030505074248.GA7812@twiddle.net>
	<16054.32214.804891.702812@panda.mostang.com>
	<20030505163444.GB9342@twiddle.net>
	<86d6ixdm6q.fsf@elgar.kettenis.dyndns.org>
	<20030506002100.GB10921@twiddle.net>
X-Mailer: VM 7.03 under Emacs 21.2.1
Reply-To: David.Mosberger@acm.org
X-URL: http://www.mostang.com/~davidm/
From: davidm@mostang.com (David Mosberger-Tang)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 5 May 2003 17:21:00 -0700, Richard Henderson <rth@twiddle.net> said:

  >> Anyway, signal trampolines could be marked with a special
  >> augmentation in their CIE.

  Richard> I'd prefer not, if at all possible.

Why?  I bet you'll live to regret it if you don't add it now. ;-)

	--david
