Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268105AbUIKLgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268105AbUIKLgr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 07:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268097AbUIKLgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 07:36:47 -0400
Received: from open.hands.com ([195.224.53.39]:49815 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S268105AbUIKLfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 07:35:51 -0400
Date: Sat, 11 Sep 2004 12:47:02 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CMedia CM9739 - sneaked in via some cheap via motherboards
Message-ID: <20040911114702.GA23783@lkcl.net>
References: <20040910222155.GA19158@lkcl.net> <1094852761.18235.2.camel@localhost.localdomain> <20040911105251.GB19158@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040911105251.GB19158@lkcl.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2004 at 11:52:52AM +0100, Luke Kenneth Casson Leighton wrote:

> > If I remember rightly the PCM on these is mute only. We fixed that for
> > OSS it may be it didnt get propogated into ALSA or this is some new
> > horrible variant. What we don't have is a fast software volume control
> > in OSS, dunno if ALSA has one.
> 
>  oh dearie me, well this chip _is_ listed as an         ac97->id == 0x434d4961
>  and no the sound ain't working.
> 
>  i'm going to pretend it does have PCM, see what happens...
 
 thanks alan because i wouldn't have known to look for the PCM switch
 if you hadn't mentioned it.


 my sincere apologies for taking up people's time on this one:
 
 a CMedia 9739 on a VIA V8235 motherboard _is_ supported...

 ... using kmix you just have to remember to flick all of the
 pretty little lights on, including the PCM "switch" which is
 of course on a different page.

 the defaults for aaaallllll switches and i mean every single one
 is yep, you guessed it: off.

 switch them on, and it works hunky-dory.


 the only thing i _would_ mention that's useful info is that
 i've set dxs_support=4 for the snd_via_82xx module: i notice
 some syslog comments asking people to report this one.

 l.


-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

