Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129134AbRC2VaM>; Thu, 29 Mar 2001 16:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129164AbRC2VaD>; Thu, 29 Mar 2001 16:30:03 -0500
Received: from ns-inetext.inet.com ([199.171.211.140]:51659 "EHLO
	ns-inetext.inet.com") by vger.kernel.org with ESMTP
	id <S129134AbRC2V3w>; Thu, 29 Mar 2001 16:29:52 -0500
Message-ID: <3AC3A920.835C9550@inet.com>
Date: Thu, 29 Mar 2001 15:29:04 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ulrich Drepper <drepper@cygnus.com>
CC: dank@trellisinc.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcnet32 compilation fix for 2.4.3pre6
In-Reply-To: <20010329210925.3161C6E099@fancypants.trellisinc.com> <m3hf0cs1xu.fsf@otr.mynet.cygnus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> 
> dank@trellisinc.com writes:
> 
> > with the new ansi standard, this use of __inline__ is no longer
> > necessary,
> 
> This is not correct.  Since the semantics of inline in C99 and gcc
> differ all code which depends on the gcc semantics should continue to
> use __inline__ since this keyword will hopefully forever signal the
> gcc semantics.

So what are the differences?  (Or, what would I read to learn the
differences?)
When are they important to us?

TIA,

Eli
-----------------------.           Rule of Accuracy: When working toward
Eli Carter             |            the solution of a problem, it always 
eli.carter(at)inet.com `------------------ helps if you know the answer.
