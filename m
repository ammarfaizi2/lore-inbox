Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129038AbQJ3L71>; Mon, 30 Oct 2000 06:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129083AbQJ3L7R>; Mon, 30 Oct 2000 06:59:17 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:14094 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129038AbQJ3L7C>; Mon, 30 Oct 2000 06:59:02 -0500
Date: Mon, 30 Oct 2000 05:58:59 -0600
To: Linux Kernel Developer <linux_developer@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Recommended compiler? - Re: [patch] kernel/module.c (plus gratuitous rant)
Message-ID: <20001030055859.C9175@wire.cadcamlab.org>
In-Reply-To: <4309.972694843@ocs3.ocs-net> <20001029232347.D4EB081F9@halfway.linuxcare.com.au> <20001030050821.B9175@wire.cadcamlab.org> <OE43voFOAmEaJswFCHO000004ac@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OE43voFOAmEaJswFCHO000004ac@hotmail.com>; from linux_developer@hotmail.com on Mon, Oct 30, 2000 at 06:19:16AM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So which is the recommended compiler for each kernel version 2.2.x,
> 2.4.x(pre?) nowadays?

* 2.91.66 aka egcs 1.1.2.  It has been officially blessed for 2.4 and
  has been given an informal thumbs-up by Alan for 2.2.  (It does NOT
  work for 2.0, if you still care about that.)

* 2.7.2.3 works for 2.2 (and 2.0) but NOT for 2.4.

* 2.95.2 seems to work with both 2.2 and 2.4 (no known bugs, AFAIK) and
  many of us use it, but it is a little riskier than egcs.

* Red Hat "2.96" or CVS 2.97 will probably break any known kernel.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
