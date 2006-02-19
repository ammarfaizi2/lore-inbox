Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWBSXEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWBSXEp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 18:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWBSXEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 18:04:45 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:40385 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751136AbWBSXEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 18:04:45 -0500
Subject: Re: No sound from SB live!
From: Lee Revell <rlrevell@joe-job.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, Nick Warne <nick@linicks.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, tiwai@suse.de, ghrt@dial.kappa.ro,
       perex@suse.cz, kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1140388095.2733.406.camel@mindpipe>
References: <20060218231419.GA3219@elf.ucw.cz>
	 <9a8748490602190304w43c32ae6m5b610f2ec9ad46f2@mail.gmail.com>
	 <7c3341450602190318o1c60e9b5w@mail.gmail.com>
	 <20060219205157.GA5976@us.ibm.com> <1140384638.2733.389.camel@mindpipe>
	 <20060219214934.GO15311@elf.ucw.cz> <1140386075.2733.399.camel@mindpipe>
	 <20060219222533.GB15608@elf.ucw.cz>  <1140388095.2733.406.camel@mindpipe>
Content-Type: text/plain
Date: Sun, 19 Feb 2006 18:04:40 -0500
Message-Id: <1140390280.2733.421.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-19 at 17:28 -0500, Lee Revell wrote:
> On Sun, 2006-02-19 at 23:25 +0100, Pavel Machek wrote:
> > I'm using static /dev... snddevices script indeed fixed that, but it
> > still does not work. (Is earphone in green connector enough?)
> > 
> 
> No idea.  There are like 50 varieties of this card.
> 
> > Ouch and that device should be still listed in devices.txt, no? 
> 
> Probably...

Hmm, OK - try *reverting* the emu10k1 fix that was in 2.6.15.4.  This
was needed to get sound on some newer SBLive! varieties but may have
broken yours.  Typical...

Lee

