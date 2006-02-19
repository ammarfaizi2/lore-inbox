Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWBSXcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWBSXcQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 18:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWBSXcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 18:32:16 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:29143 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932406AbWBSXcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 18:32:15 -0500
Subject: Re: No sound from SB live!
From: Lee Revell <rlrevell@joe-job.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Pavel Machek <pavel@suse.cz>, Nishanth Aravamudan <nacc@us.ibm.com>,
       Nick Warne <nick@linicks.net>, Jesper Juhl <jesper.juhl@gmail.com>,
       tiwai@suse.de, ghrt@dial.kappa.ro, perex@suse.cz,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200602192323.08169.s0348365@sms.ed.ac.uk>
References: <20060218231419.GA3219@elf.ucw.cz>
	 <20060219214702.GM15311@elf.ucw.cz> <1140385837.2733.394.camel@mindpipe>
	 <200602192323.08169.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Date: Sun, 19 Feb 2006 18:32:09 -0500
Message-Id: <1140391929.2733.430.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-19 at 23:23 +0000, Alistair John Strachan wrote:
> I'm still using 1.0.9 on 2.6.16-rc4 with no problems, Audigy 2 (one
> that uses 
> emu10k1). 

It's a specific change to the SBLive! that did not affect the Audigy
that causes alsa-lib 1.0.10+ to be required on 2.6.14 and up.  These
types of incompatible changes should be rare.

It was a necessary precursor to fixing the well known "master volume
only controls front speakers" bug.

Lee

