Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267123AbTAPRpn>; Thu, 16 Jan 2003 12:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267124AbTAPRpn>; Thu, 16 Jan 2003 12:45:43 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:40174 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S267123AbTAPRpm>;
	Thu, 16 Jan 2003 12:45:42 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15910.61917.904202.235234@napali.hpl.hp.com>
Date: Thu, 16 Jan 2003 09:54:37 -0800
To: jim.houston@attbi.com
Cc: linux-kernel@vger.kernel.org,
       high-res-timers-discourse@lists.sourceforge.net, jim.houston@ccur.com
Subject: Re: [PATCH] improved boot time TSC synchronization
In-Reply-To: <200301161644.h0GGitX02052@linux.local>
References: <200301161644.h0GGitX02052@linux.local>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 16 Jan 2003 11:44:55 -0500, Jim Houston <jim.houston@attbi.com> said:

  Jim> The current TSC synchronization may have an error on the order
  Jim> of 1 microsecond on a quad processor system.  Not a big deal
  Jim> but annoying if you are trying to figure out what order things
  Jim> happen based on TSC time stamps.

  Jim> Since the IA64 folk already solved this problem, I did a quick
  Jim> hack based on the itc sync code.

Cool.  I'm glad to see the code is proving useful on other architectures.
I was hoping that would be the case.

BTW: The algorithm is documented in Section 8.5.2 of my book (see
http://www.lia64.org/book/).  If there is enough interested, I'd be
willing to try to talk the publisher into releasing that section as a
PDF (or perhaps HTML).

	--david
