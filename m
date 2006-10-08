Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWJHQkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWJHQkh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 12:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWJHQkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 12:40:37 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:35266 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751268AbWJHQkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 12:40:36 -0400
Subject: Re: PCM distorsion snapshots from SATA/ALSA conflict (was:
	[Alsa-user] Pb with simultaneous SATA and ALSA I/O)
From: Lee Revell <rlrevell@joe-job.com>
To: Dominique Dumont <domi.dumont@free.fr>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       alsa-user <alsa-user@lists.sourceforge.net>,
       Francesco Peeters <Francesco@FamPeeters.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <878xjrqeh2.fsf_-_@gandalf.hd.free.fr>
References: <877izsp3dm.fsf@gandalf.hd.free.fr>
	 <13158.212.123.217.246.1159186633.squirrel@www.fampeeters.com>
	 <87y7rusddc.fsf@gandalf.hd.free.fr> <1160081110.2481.104.camel@mindpipe>
	 <87r6xmscif.fsf@gandalf.hd.free.fr> <1160082761.2481.106.camel@mindpipe>
	 <1160085016.1607.26.camel@localhost.localdomain>
	 <878xjrqeh2.fsf_-_@gandalf.hd.free.fr>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 12:41:13 -0400
Message-Id: <1160325674.17615.107.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(it's probably a bad idea to attach .jpgs to a LKML post - please post
them on the web and send a URL)

On Sun, 2006-10-08 at 12:38 +0200, Dominique Dumont wrote:
> Anyway, the oscilloscope shows that:
> - a spike occurs every 330 useconds (about 3kHz)
>   (note: 330us is 15.85 times the period of the 48KHz spdif stream) 
> - the spike level roughly matches the level of the sine waves 330
>   useconds sooner
> 

You seem to be using a period size of 256 samples - any change if you
use a larger period size?

Any change if you use setpci to increase LATENCY_TIMER for the SBLive!
card?

Lee

