Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbULBQ0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbULBQ0p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 11:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbULBQ0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 11:26:44 -0500
Received: from mail.joq.us ([67.65.12.105]:37810 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261670AbULBQ0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 11:26:36 -0500
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Andrew Burgess <aab@cichlid.com>, linux-kernel@vger.kernel.org,
       jackit-devel@lists.sourceforge.net
Subject: Re: [Jackit-devel] Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-19
References: <200412021546.iB2FkK5a005502@cichlid.com>
	<20041202170315.067d7853@mango.fruits.de>
From: "Jack O'Quin" <joq@io.com>
Date: 02 Dec 2004 10:26:55 -0600
In-Reply-To: <20041202170315.067d7853@mango.fruits.de>
Message-ID: <87y8ggekds.fsf@sulphur.joq.us>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thu, 2 Dec 2004 07:46:20 -0800
> Andrew Burgess <aab@cichlid.com> wrote:
> > On further thought, I suppose libjack could install a SIGUSR2 handler and
> > have that call abort for all the rt client threads. Still no client mods
> > needed, only an RT-aware libjack.

Florian Schmidt <mista.tapas@gmx.net> writes:
> right. Or instead of aborting jackd might print a debug output (like
> "client foo violated RT constraints"). 

Libjack cannot assume the client has no SIGUSR2 handler of its own.

> > A big thank you to Ingo and everyone else involved on behalf of all the
> > linux audio users!

thanks++  :-)

> BTW: i suppose pretty much every jack client except for very simple ones
> do break the RT constraints.

True.  

It would be wonderful to have a reliable mechanism for debugging them.
-- 
  joq
