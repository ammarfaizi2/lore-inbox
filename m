Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317935AbSHHUH4>; Thu, 8 Aug 2002 16:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317960AbSHHUH4>; Thu, 8 Aug 2002 16:07:56 -0400
Received: from pat.uio.no ([129.240.130.16]:57314 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S317935AbSHHUHz>;
	Thu, 8 Aug 2002 16:07:55 -0400
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.30+] Second attempt at a shared credentials patch
References: <23130000.1028818693@baldur.austin.ibm.com>
	<shsofcdfjt6.fsf@charged.uio.no>
	<44050000.1028823650@baldur.austin.ibm.com>
	<15698.41542.250846.334946@charged.uio.no>
	<52960000.1028829902@baldur.austin.ibm.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 08 Aug 2002 22:11:30 +0200
In-Reply-To: <52960000.1028829902@baldur.austin.ibm.com>
Message-ID: <shsadnxm7pp.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


BTW: if you'd like an example the sort of thing I'm talking about,
please take a quick look at

  http://www.fys.uio.no/~trondmy/src/bsdcred/linux-2.5.1-pre11_cred.dif

That was a start at doing credentials POSIX threads. It doesn't have
the 'capabilities' stuff merged into the struct task (the patch itself
is incomplete, out of date, and just as monolithic as yours) but it
does illustrate what I mean about the relationship between the struct
cred and the ucred stuff, and also illustrates how one might share the
struct ucred with the struct file.

Cheers,
  Trond
