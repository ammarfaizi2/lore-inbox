Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131289AbRCHITf>; Thu, 8 Mar 2001 03:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131290AbRCHITZ>; Thu, 8 Mar 2001 03:19:25 -0500
Received: from kerberos.suse.cz ([195.47.106.10]:16147 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S131289AbRCHITO>;
	Thu, 8 Mar 2001 03:19:14 -0500
Date: Thu, 8 Mar 2001 09:17:06 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: John Heil <kerndev@sc-software.com>
Cc: George Garvey <tmwg-linuxknl@inxservices.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac12 (vt82c686 info)
Message-ID: <20010308091706.B799@suse.cz>
In-Reply-To: <20010307201437.A5030@suse.cz> <Pine.LNX.3.95.1010307131509.31180A-100000@scsoftware.sc-software.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1010307131509.31180A-100000@scsoftware.sc-software.com>; from kerndev@sc-software.com on Wed, Mar 07, 2001 at 01:23:49PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2001 at 01:23:49PM +0000, John Heil wrote:

> > Also, the vt82c686 will work just fine with Linux, but will be limited
> > to UDMA33, because UDMA66 on this chip does reliably fail.
> 
> Based on following the lkml threads on Via chipsets, it seems that
> the 686a at or above rev 22, will run UDMA66 just fine.
> Below that, lies the flakiness...
> My Tyan based 686a rev 22 has been trouble free save a bad cable.

686 rev 00-0f => 686,  UDMA33 (UDMA66 broken, chip very rare)
686 rev 10-2f => 686a, UDMA66
686 rev 40    => 686b, UDMA100

> I just acquired a new 1.1G athlon on an asus a7v133. It has a 686b.
> What should I expect w the 686b?  and is the Via 686b data sheet 
> available somewhere? 

Make sure you use the latest 2.4.2-acxx drivers. Most other versions of
my drivers have little bugs in the 686b support. Harmless but somewhat
annoying.

-- 
Vojtech Pavlik
SuSE Labs
