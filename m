Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268864AbUJPUnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268864AbUJPUnN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 16:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268877AbUJPUnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 16:43:12 -0400
Received: from gprs214-153.eurotel.cz ([160.218.214.153]:50048 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268864AbUJPUmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 16:42:21 -0400
Date: Sat, 16 Oct 2004 22:42:06 +0200
From: Pavel Machek <pavel@suse.cz>
To: M?ns Rullg?rd <mru@mru.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: High pitched noise from laptop: processor.c in linux 2.6
Message-ID: <20041016204206.GB24434@elf.ucw.cz>
References: <41650CAF.1040901@unimail.com.au> <20041007103210.GA32260@atrey.karlin.mff.cuni.cz> <yw1x7jq2n6k3.fsf@mru.ath.cx> <20041007143245.GA1698@openzaurus.ucw.cz> <yw1x1xfyl9ia.fsf@ford.guide>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1x1xfyl9ia.fsf@ford.guide>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> >> code didn't help much, I don't know C. 
> >> >
> >> > Change #define HZ 1000 to #define HZ 100...
> >> 
> >> ... and lose all the benefits of HZ=1000.  
> >
> > What benefits? HZ=1000 takes 1W more on my system.
> 
> Isn't it supposed to give more accurate timing?

Well, yes, but if it beeps for you... Accurate timing is probably not
that important.

> > 64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         
> 
> Has that really happened?

Yes. On gprs it is rather easy to reproduce, unfortunately...

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
