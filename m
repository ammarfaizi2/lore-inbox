Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130507AbRDWEof>; Mon, 23 Apr 2001 00:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130532AbRDWEoZ>; Mon, 23 Apr 2001 00:44:25 -0400
Received: from pizda.ninka.net ([216.101.162.242]:52631 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130507AbRDWEoL>;
	Mon, 23 Apr 2001 00:44:11 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15075.45847.624767.960502@pizda.ninka.net>
Date: Sun, 22 Apr 2001 21:44:07 -0700 (PDT)
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: All architecture maintainers: pgd_alloc()
In-Reply-To: <20010421154455.C7576@flint.arm.linux.org.uk>
In-Reply-To: <20010421154455.C7576@flint.arm.linux.org.uk>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Russell King writes:
 > There are various options here:
 > 
 > 1. Either I can fix up all architectures, and send a patch to this list, or

Fixup all the architectures and send this and the ARM bits to Linus.

I really would wish folks would not choose Alan as the first place
to send the patch.  I'm not directly accusing anyone of it, but it
does appear that often AC is used as a "back door" to get a change
in.  While this scheme most of the time, often it unnecessarily
overworks Alan which I think is unfair.

Sending it to Linus first also eliminates 2 levels of indirection
each time Linus wants something done differently in the change.

	person --> alan --> linus --> needs change

	alan BCC's person, person codes new version

	person --> alan --> linus --> etc. etc.

Sure Alan could fix it up himself, but...

My main point is that for changes like this, sending stuff to Alan
first is often an ineffective mechanism.  If someone were to reply to
this "Linus is hard to push changes too, or takes too long" my reply
is "if this is really the problem, should the burdon should be
entirely placed on Alan's shoulders?"

The AC patches are huge, but they have substantially decreased in size
during the recent 2.4.4-preX series.  And sure, Alan makes conscious
decisions to apply patches and eventually work to push them to Linus,
but honestly people should consider ways to help decrease his load.

Later,
David S. Miller
davem@redhat.com
