Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268436AbUHQVCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268436AbUHQVCH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 17:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268442AbUHQVCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 17:02:06 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:17837 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268436AbUHQU7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 16:59:14 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
From: Lee Revell <rlrevell@joe-job.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <20040817205255.GA32252@k3.hellgate.ch>
References: <20040810132654.GA28915@elte.hu>
	 <20040812235116.GA27838@elte.hu> <1092382825.3450.19.camel@mindpipe>
	 <20040813104817.GI8135@elte.hu> <1092432929.3450.78.camel@mindpipe>
	 <20040814072009.GA6535@elte.hu> <20040815115649.GA26259@elte.hu>
	 <1092612264.867.9.camel@krustophenia.net>
	 <20040816080745.GA18406@k3.hellgate.ch>
	 <1092696835.13981.61.camel@krustophenia.net>
	 <20040817205255.GA32252@k3.hellgate.ch>
Content-Type: text/plain
Message-Id: <1092776417.1297.4.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 17 Aug 2004 17:00:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-17 at 16:52, Roger Luethi wrote:
> On Mon, 16 Aug 2004 18:53:56 -0400, Lee Revell wrote:
> > What do you think of Ingo's solution of trying to move the problematic
> > call to mdio_read out of the spinlocked section?  It does seem that the
> 
> Can't comment on that, I missed it. I am aware that locking in via-rhine
> needs work, though, it's one of the things I haven't touched.
> 
> > awfully long time.  In a live audio setting you would actually get lots
> > of media events.
> 
> Don't trip over the network cables. Duh.
> 

You might want to intentionally plug or unplug them.  Live music != a
server room.  Think laptop DJs.  It would be bad if plugging into the
network caused a click in your sound output - this could be VERY loud
depnding on the setting!

This will become more important once Linux has good
audio/midi-over-ethernet support.  You might be playing sound out of
your sound interface, and sending the same sound over the network as UDP
packets for recording or additional processing.

Lee

