Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268845AbUJPTte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268845AbUJPTte (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 15:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268803AbUJPTlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 15:41:39 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21704 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268802AbUJPTjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 15:39:06 -0400
Date: Thu, 7 Oct 2004 16:34:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: M <mru@mru.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: High pitched noise from laptop: processor.c in linux 2.6
Message-ID: <20041007143440.GB1698@openzaurus.ucw.cz>
References: <41650CAF.1040901@unimail.com.au> <20041007103210.GA32260@atrey.karlin.mff.cuni.cz> <yw1x7jq2n6k3.fsf@mru.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1x7jq2n6k3.fsf@mru.ath.cx>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> Is there any way to stop this? I googled around and found it had 
> >> something to do with idle frequency of 1000 Hz in 2.6 instead of 100Hz 
> >> in the 2.4 kernel. I couldn't find much else on this. Hunting around the 
> >> code didn't help much, I don't know C. 
> >
> > Change #define HZ 1000 to #define HZ 100...
> 
> ... and lose all the benefits of HZ=1000.  What would happen if one
> were to set HZ to a higher value, like 10000?

You'll probably get even uglier noise and 5%+ performance penalty.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

