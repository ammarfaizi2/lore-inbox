Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317396AbSGISd0>; Tue, 9 Jul 2002 14:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317397AbSGISdZ>; Tue, 9 Jul 2002 14:33:25 -0400
Received: from grunt.ksu.ksu.edu ([129.130.12.17]:47515 "EHLO
	mailhub.cns.ksu.edu") by vger.kernel.org with ESMTP
	id <S317396AbSGISdZ>; Tue, 9 Jul 2002 14:33:25 -0400
Date: Tue, 9 Jul 2002 13:36:07 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: Michael Gruner <stockraser@yahoo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: freezing afer switching from graphical to console
Message-ID: <20020709133606.A8202@ksu.edu>
Mail-Followup-To: Michael Gruner <stockraser@yahoo.de>,
	linux-kernel@vger.kernel.org
References: <1026193021.1076.29.camel@highflyer> <200207091227.15957.bernd-schubert@web.de> <1026232702.757.9.camel@highflyer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: RE: [Re: freezing afer switching from graphical to console]
X-School: Kansas State University
X-vi-or-emacs: vi
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Michael Gruner on Tuesday, 09 July, 2002:
>Hi,
>ok, did it as you say: in the BIOS I switched to Vsync/blank screen.
>Let's see what happens.
>BTW: My graphics card isn't a nvidia as many of you suggested but an ATI
>Rage pro (what did you wrote Bernd? ;-) ).
>Another interesting thing I got back in mind today was: one day my XMMS
>played a mp3 song and I switched to console (oooops...you know what
>happend) but the song kept on playing in a loop that was some
>milliseconds until I powered the box off. I don't know what to think
>about that.

I've seen the same thing on my ATI XPert@Play (Rage Pro chipset).  At 
  2.4.17, it was a risky proposition to switch between X and a text VC.
  It's better in 2.4.18, although not much (I believe.  I may be wrong).
  I have happend upon a situation a number of times where, when switching
  from X to a text VC, the machine "locks up", but CTRL-F7 (the X VC) will
  get me back to a working X login screen (KDM), at least for a while.  If
  I keep trying to switch to a text VC (which never works), it eventually
  fully locks up, to the point where I have to pull the plug, since the on
  switch is non-responsive.  If I tell it to shut down, it gets *most* of
  the way through before carping out and locking up fully.
I don't *believe* I've seen this in 2.5.x, although I may be wrong.

-Joseph
-- 
Joseph======================================================jap3003@ksu.edu
"We're moving toward a world where all the capabilities of the Internet are
 reprocessed through a single filter, with Microsoft's business plan behind
 it."  Mozilla's Mitchell Baker, http://news.com.com/2100-1023-941926.html
