Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272878AbRIGW1e>; Fri, 7 Sep 2001 18:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272879AbRIGW1Y>; Fri, 7 Sep 2001 18:27:24 -0400
Received: from grunt.ksu.ksu.edu ([129.130.12.17]:50636 "EHLO
	mailhub.cns.ksu.edu") by vger.kernel.org with ESMTP
	id <S272878AbRIGW1S>; Fri, 7 Sep 2001 18:27:18 -0400
Date: Fri, 7 Sep 2001 17:27:37 -0500
From: Joseph Pingenot <jap3003@ksu.edu>
To: Alex Deucher <agd5f@yahoo.com>
Cc: linux-on-portege@yahoogroups.com, linux-kernel@vger.kernel.org
Subject: Re: Toshiba IDE DMA support
Message-ID: <20010907172737.A17636@ksu.edu>
Reply-To: jap3003+response@ksu.edu
Mail-Followup-To: Alex Deucher <agd5f@yahoo.com>,
	linux-on-portege@yahoogroups.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010907163513.62384.qmail@web11304.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: RE: [Toshiba IDE DMA support]
X-School: Kansas State University
X-vi-or-emacs: vi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Alex Deucher on Friday, 07 September, 2001:
>I just received the documention for the IDE conrollers
>in may older Toshiba notebooks.  These controllers are
>capable of DMA, but at the moment do not have it
>implemented.  I know nothing about programming IDE
>drivers, so if anyone is interested in developing
>these drivers shoot me an email and I can send you the
>docs and help with testing (I have several notebooks
>to test on).  I'd like to get into it myself, but just
>don't have the time.

Heh.  "No time."  Sounds familiar.  :)
I don't have the knoff-hoff (know-how) either, but I'd like
  to know what models you have info on.  I'd be very interested
  in any documentation you might have on the Satellite 1605CDS.
  At the very least, I like to collect info so that it's available
  later on.
I have DMA enabled on my Satellite 1605CDS, but only via a hack.
  If I enable ALi 15xx support in the kernel, I find that I can't
  suspend my laptop to disk (it hands off to BIOS well, but then
  BIOS freezes when it starts to save the "Extended" memory.)
  So, what I do is build an ALi-enabled kernel, then reboot to
  a non-ALi-enabled kernel.  For some reason, it saves this
  DMA-enabled info between soft reboots.  So, since it's Linux
  and I essentially never have to hard-reboot (or even give it
  the 3-finger salute) this works fairly well.  It's only when
  it's actually been shut off or hard rebooted (via the switch)
  that DMA gets disabled again.
I'd like to fix the ALi support so I can suspend to disk, but I
  don't know where to begin.  I don't have the specs.
Where did you get this info?  I'd be very curious what else we
  can get out.

                              -Joseph
-- 
Joseph==============================================jap3003@ksu.edu
"The message that 'resistance is futile' has been hammered home.
  The only OS projects that stand a chance [against Microsoft] are
  open source, because they don't play by the rules of the economy."
http://www.byte.com/documents/s=1115/byt20010824s0001
