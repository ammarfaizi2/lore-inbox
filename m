Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbTH0HiK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 03:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263044AbTH0HiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 03:38:10 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:63667 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S263019AbTH0HiI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 03:38:08 -0400
Date: Wed, 27 Aug 2003 10:37:58 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org, tejun@aratech.co.kr
Subject: Re: 2.4.22pre8 hangs too (Re: 2.4.21-jam1 solid hangs)
Message-ID: <20030827073758.GW83336@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	linux-kernel@vger.kernel.org, tejun@aratech.co.kr
References: <20030729073948.GD204266@niksula.cs.hut.fi> <20030730071321.GV150921@niksula.cs.hut.fi> <Pine.LNX.4.55L.0307301149550.29648@freak.distro.conectiva> <20030730181003.GC204962@niksula.cs.hut.fi> <20030827064301.GF150921@niksula.cs.hut.fi> <20030827071259.GV83336@niksula.cs.hut.fi> <20030827092139.4d75ef4a.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030827092139.4d75ef4a.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 09:21:39AM +0200, you [Stephan von Krawczynski] wrote:
> 
> Sorry, then you have to look for another explanation. 

Yep, but I don't have any reasonable suspects.

> Did you already try to exchange everything but the harddisks ?

No. Do you suspect faulty hardware?

Apart from perhaps Adaptec 2940 (Adaptecs always give me trouble), I
believe the hw is pretty solid. It had no problems with 2.2 kernels.  Based
on my experience, the i815 chipset is not that shaky (unlike the Via dung),
and I would expect the Intel motherboard to be on the better side as well.

I can't completely rule faulty hw out, though.

Exchanging hw will be quite difficult, as the hangs take as much as three
weeks to trigger (sometimes they happen withing a day after reboot), the box
is a production server, and I don't have much spare hardware atm.

What I had hoped for is to be able to get some information on where it hangs.
But sysrq and nmi watchdog don't cut it...


-- v --

v@iki.fi
