Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268160AbTBNDEc>; Thu, 13 Feb 2003 22:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268161AbTBNDEc>; Thu, 13 Feb 2003 22:04:32 -0500
Received: from almesberger.net ([63.105.73.239]:46603 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S268160AbTBNDEb>; Thu, 13 Feb 2003 22:04:31 -0500
Date: Fri, 14 Feb 2003 00:13:10 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Corey Minyard <cminyard@mvista.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, suparna@in.ibm.com,
       Kenneth Sumrall <ken@mvista.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net
Subject: Re: Kexec, DMA, and SMP
Message-ID: <20030214001310.B2791@almesberger.net>
References: <m18ywoyq78.fsf@frodo.biederman.org> <20030211182508.A2936@in.ibm.com> <20030211191027.A2999@in.ibm.com> <3E490374.1060608@mvista.com> <20030211201029.A3148@in.ibm.com> <3E4914CA.6070408@mvista.com> <m1of5ixgun.fsf@frodo.biederman.org> <3E4A578C.7000302@mvista.com> <m13cmty2kq.fsf@frodo.biederman.org> <3E4A70EA.4020504@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E4A70EA.4020504@mvista.com>; from cminyard@mvista.com on Wed, Feb 12, 2003 at 10:06:02AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey Minyard wrote:
> Another thought.  If you add a delay with all other processors and 
> interrupts off, the disk devices
> will run out of things to do.

But the network will be there, patiently waiting for its chance to
strike. Likewise, I guess: USB (e.g. move the mouse at the wrong
moment to crash the system).

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
