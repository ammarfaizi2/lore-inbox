Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312026AbSCQNha>; Sun, 17 Mar 2002 08:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312025AbSCQNhU>; Sun, 17 Mar 2002 08:37:20 -0500
Received: from ns.suse.de ([213.95.15.193]:44037 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312027AbSCQNhG>;
	Sun, 17 Mar 2002 08:37:06 -0500
Date: Sun, 17 Mar 2002 14:37:05 +0100
From: Dave Jones <davej@suse.de>
To: S W <egberts@yahoo.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre2 CentaurHauls VIA Samuel 2 stepping 2 SEGFAULT (RESOLVED)
Message-ID: <20020317143705.B4006@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	S W <egberts@yahoo.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E16mLIY-00079l-00@the-village.bc.nu> <20020317042241.70303.qmail@web10504.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020317042241.70303.qmail@web10504.mail.yahoo.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 08:22:41PM -0800, S W wrote:
 > I pulled the chipset datasheet for CentaurHauls VIA
 > Samuel 2 stepping 2.
 > 
 > Two seperate i386/kernel/setup.c fixes things seems to
 > fix this chipset.
 > 
 > 1.  Disabled the Branch Predictor in MSR_VIA_FCR
 > 2.  cachesize=0
 > I've settled for cachesize=0.
 > Hope this is not a trend here.

 Not on the samples I've tested with. I think you have flaky hardware.
 Either there is insufficient cooling/power, or the cache is dead.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
