Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132706AbQL3G00>; Sat, 30 Dec 2000 01:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132999AbQL3G0Q>; Sat, 30 Dec 2000 01:26:16 -0500
Received: from Cantor.suse.de ([194.112.123.193]:29457 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132706AbQL3G0G>;
	Sat, 30 Dec 2000 01:26:06 -0500
Date: Sat, 30 Dec 2000 06:55:36 +0100
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Byron Stanoszek <gandalf@winds.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <aviro@redhat.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, "Marco d'Itri" <md@Linux.IT>,
        Jeff Lightfoot <jeffml@pobox.com>, Dan Aloni <karrde@callisto.yi.org>,
        Anton Blanchard <anton@linuxcare.com.au>
Subject: Re: test13-pre6 (Fork Bug with Athlons? Temporary Fix)
Message-ID: <20001230065536.A10221@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.21.0012292156200.11714-200000@winds.org> <Pine.LNX.4.10.10012291929250.1722-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012291929250.1722-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Dec 29, 2000 at 07:36:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2000 at 07:36:21PM -0800, Linus Torvalds wrote:
> Maybe your libc is different on the different machines? Normal programs
> shouldn't use segments at all, so I really do not see how this patch could
> matter in the least, even if it was completely and utterly buggy (which is
> not obvious at first glance).
> 
> I wonder why you seem to have an LDT at all..

glibc 2.2 linuxthreads sets up an LDT to use %gs as thread local data base 
pointer.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
