Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265574AbSJXRqv>; Thu, 24 Oct 2002 13:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265578AbSJXRqv>; Thu, 24 Oct 2002 13:46:51 -0400
Received: from 173.75.202.62.dial.bluewin.ch ([62.202.75.173]:12928 "EHLO
	k3.hellgate.ch") by vger.kernel.org with ESMTP id <S265574AbSJXRqu>;
	Thu, 24 Oct 2002 13:46:50 -0400
Date: Thu, 24 Oct 2002 19:53:01 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [CFT] faster athlon/duron memory copy implementation
Message-ID: <20021024175301.GA1229@k3.hellgate.ch>
Mail-Followup-To: Manfred Spraul <manfred@colorfullife.com>,
	linux-kernel@vger.kernel.org, arjanv@redhat.com
References: <3DB82ABF.8030706@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB82ABF.8030706@colorfullife.com>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.44 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Athlon 1400, ALi chipset, 1 GB SDRAM

Deviation in 3 runs < 1%.

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $ 

copy_page() tests 
copy_page function 'warm up run'	 took 29353 cycles per page
copy_page function '2.4 non MMX'	 took 34621 cycles per page
copy_page function '2.4 MMX fallback'	 took 34606 cycles per page
copy_page function '2.4 MMX version'	 took 29239 cycles per page
copy_page function 'faster_copy'	 took 17236 cycles per page
copy_page function 'even_faster'	 took 17453 cycles per page
copy_page function 'no_prefetch'	 took 12628 cycles per page
