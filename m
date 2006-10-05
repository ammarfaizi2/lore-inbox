Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbWJEVp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWJEVp7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWJEVpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:45:14 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:3720 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932292AbWJEVpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:45:11 -0400
Subject: Re: [Alsa-user] Pb with simultaneous SATA and ALSA I/O
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dominique Dumont <domi.dumont@free.fr>,
       Francesco Peeters <Francesco@FamPeeters.com>,
       alsa-user <alsa-user@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1160085133.1607.29.camel@localhost.localdomain>
References: <877izsp3dm.fsf@gandalf.hd.free.fr>
	 <13158.212.123.217.246.1159186633.squirrel@www.fampeeters.com>
	 <87y7rusddc.fsf@gandalf.hd.free.fr>  <1160081110.2481.104.camel@mindpipe>
	 <1160085133.1607.29.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 17:45:36 -0400
Message-Id: <1160084737.2481.112.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-05 at 22:52 +0100, Alan Cox wrote:
> Ar Iau, 2006-10-05 am 16:45 -0400, ysgrifennodd Lee Revell:
> > I've heard that some motherboards do evil stuff like implementing legacy drive
> > access modes using SMM which would cause dropouts without xruns
> > reported.
> 
> They don't. SATA causes audio dropouts on some systems because its fast
> enough to starve the audio device of regular enough access to the PCI
> bus. If that is a problem the audio device should be tuning PCI
> latencies
> 

OK.  In fact the Windows driver and IIRC the OSS driver do tune PCI
latencies.  But that can't be the problem here if analog playback is
unaffected.  Sounds like electrical noise could be the issue...

Lee

