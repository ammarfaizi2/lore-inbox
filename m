Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265514AbTFSUfQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 16:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265481AbTFSUfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 16:35:08 -0400
Received: from adsl-66-127-195-58.dsl.snfc21.pacbell.net ([66.127.195.58]:47567
	"EHLO panda.mostang.com") by vger.kernel.org with ESMTP
	id S265514AbTFSUdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 16:33:02 -0400
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org, davidm@hpl.hp.com
Reply-To: davidm@hpl.hp.com
Subject: Re: common name for the kernel DSO
References: <20030618192007$14a5@gated-at.bofh.it>
	<20030619062011$555e@gated-at.bofh.it>
	<20030619192018$5cab@gated-at.bofh.it>
From: David Mosberger-Tang <David.Mosberger@acm.org>
Date: 19 Jun 2003 13:26:42 -0700
In-Reply-To: <20030619192018$5cab@gated-at.bofh.it>
Message-ID: <ug3ci5zud9.fsf@panda.mostang.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 19 Jun 2003 21:20:19 +0200, Jamie Lokier <jamie@shareable.org> said:

  Jamie> H. Peter Anvin wrote:
  >> It's a pretty ugly name, quite frankly, since it doesn't explain
  >> what it is a gate from or to.  linux-syscall.so.1 or
  >> linux-kernel.so.1 would make a lot more sense.

  Jamie> linux-syscall.so.1 makes most sense to me.

  Jamie> It's the only one which is correct and unambiguous.

It's not really correct.  The DSO can be used for up-calls (e.g.,
signal trampolines), too.

Like I said, I can _live_ with "syscall", but would prefer "gate",
because it's technically more accurate.  It's also shorter, always a
bonus... ;-)

	--david
