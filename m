Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284678AbRLEUSq>; Wed, 5 Dec 2001 15:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284663AbRLEUS3>; Wed, 5 Dec 2001 15:18:29 -0500
Received: from pizda.ninka.net ([216.101.162.242]:52870 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S284676AbRLEURo>;
	Wed, 5 Dec 2001 15:17:44 -0500
Date: Wed, 05 Dec 2001 12:17:00 -0800 (PST)
Message-Id: <20011205.121700.88471929.davem@redhat.com>
To: rth@redhat.com
Cc: davidm@hpl.hp.com, schwab@suse.de, linux-ia64@linuxia64.org,
        marcelo@conectiva.com.br, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: alpha bug in signal handling
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011205085808.A8634@redhat.com>
In-Reply-To: <20011204190048.B8179@redhat.com>
	<20011205.032304.102576056.davem@redhat.com>
	<20011205085808.A8634@redhat.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Richard Henderson <rth@redhat.com>
   Date: Wed, 5 Dec 2001 08:58:08 -0800
   
   It doesn't.  But it also prevents the IPI from being recognized
   until we are back in userland.  Apparently DMT had a test case
   that failed without disabling interrupts; I didn't see it myself.

I would like to see this test case :-)
