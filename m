Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290729AbSBLCqi>; Mon, 11 Feb 2002 21:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290739AbSBLCqW>; Mon, 11 Feb 2002 21:46:22 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:31220 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S290729AbSBLCqE>;
	Mon, 11 Feb 2002 21:46:04 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15464.33256.837784.657759@napali.hpl.hp.com>
Date: Mon, 11 Feb 2002 18:46:00 -0800
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, anton@samba.org, linux-kernel@vger.kernel.org,
        zippel@linux-m68k.org
Subject: Re: thread_info implementation
In-Reply-To: <20020211.183603.111204707.davem@redhat.com>
In-Reply-To: <15464.30088.754007.311391@napali.hpl.hp.com>
	<20020211.182208.102575913.davem@redhat.com>
	<15464.32354.452126.182563@napali.hpl.hp.com>
	<20020211.183603.111204707.davem@redhat.com>
X-Mailer: VM 7.00 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 11 Feb 2002 18:36:03 -0800 (PST), "David S. Miller" <davem@redhat.com> said:

  DaveM> All performance tests I ran were "about the same" on sparc64,
  DaveM> on x86 we really only have one anomaly on one of Linus's SMP
  DaveM> x86 machines (fork+exec from lmbench on dual-Athlon) and I'm
  DaveM> going to push to investigate that further.

OK, so back to square one: why am I supposed to do all this work for
something that will likely slow things slightly down and, at best,
doesn't hurt performance?  The old set up works great and as far as
I'm concerned, is not broken.

Don't get me wrong. I'm willing to invest time to switch to the new
setup, but I'd like to have a good reason before doing so.  That's not
asking for too much, is it?

	--david
