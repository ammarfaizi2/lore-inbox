Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267712AbTGLFmo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 01:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267716AbTGLFmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 01:42:44 -0400
Received: from palrel12.hp.com ([156.153.255.237]:16782 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S267712AbTGLFmo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 01:42:44 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16143.41797.797147.206845@napali.hpl.hp.com>
Date: Fri, 11 Jul 2003 22:57:25 -0700
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: utimes/futimes/lutimes syscalls
In-Reply-To: <3F0F9E9A.9050502@redhat.com>
References: <3F0F9B0C.10604@redhat.com>
	<3F0F9E9A.9050502@redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 11 Jul 2003 22:37:30 -0700, Ulrich Drepper <drepper@redhat.com> said:

  Uli> Replying to myself: utimes() is already available, on some
  Uli> architectures.  The question is why not for archs != alpha,
  Uli> ia64, PA, SPARC?

Do you have this backwards?  ia64 has utimes(), but not utime().  The
same should be true for Alpha.

	--david
