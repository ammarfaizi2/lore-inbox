Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWAEU2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWAEU2V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 15:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWAEU2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 15:28:21 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:36805 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932155AbWAEU2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 15:28:20 -0500
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
From: Lee Revell <rlrevell@joe-job.com>
To: Marcin Dalecki <martin@dalecki.de>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Takashi Iwai <tiwai@suse.de>,
       Jesper Juhl <jesper.juhl@gmail.com>, Adrian Bunk <bunk@stusta.de>,
       Tomasz Torcz <zdzichu@irc.pl>, Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <7B34B941-46CC-478F-A870-43FE0D3143AB@dalecki.de>
References: <20050726150837.GT3160@stusta.de>
	 <200601031522.06898.s0348365@sms.ed.ac.uk> <20060103160502.GB5262@irc.pl>
	 <200601031629.21765.s0348365@sms.ed.ac.uk>
	 <20060103170316.GA12249@dspnet.fr.eu.org> <s5h1wzpnjrx.wl%tiwai@suse.de>
	 <20060103203732.GF5262@irc.pl> <s5hvex1m472.wl%tiwai@suse.de>
	 <9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com>
	 <20060103215654.GH3831@stusta.de>
	 <9a8748490601031411p17d4417fyffbfee00ca85ac82@mail.gmail.com>
	 <s5hpsn8md1j.wl%tiwai@suse.de>
	 <Pine.LNX.4.61.0601041545580.5750@yvahk01.tjqt.qr>
	 <F082489C-B664-472C-8215-BE05875EAF7D@dalecki.de>
	 <Pine.LNX.4.61.0601051154500.21555@yvahk01.tjqt.qr>
	 <0D76E9E1-7FB0-41FD-8FAC-E4B3C6E9C902@dalecki.de>
	 <1136486021.31583.26.camel@mindpipe>
	 <E09E5A76-7743-4E0E-9DF6-6FB4045AA3CF@dalecki.de>
	 <1136491503.847.0.camel@mindpipe>
	 <7B34B941-46CC-478F-A870-43FE0D3143AB@dalecki.de>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 15:28:15 -0500
Message-Id: <1136492896.847.21.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-05 at 21:18 +0100, Marcin Dalecki wrote:
> On 2006-01-05, at 21:05, Lee Revell wrote:
> 
> > On Thu, 2006-01-05 at 21:03 +0100, Marcin Dalecki wrote:
> >> On 2006-01-05, at 19:33, Lee Revell wrote:
> >>
> >>> On Thu, 2006-01-05 at 13:44 +0100, Marcin Dalecki wrote:
> >>>> Second - you still didn't explain why this allows you to conclude
> >>>> that sound mixing should in no way be done inside the kernel.
> >>>
> >>> It works perfectly right now in userspace.
> >>
> >> Yeah - for you maybe...
> >>
> >
> > Please rephrase your comment in the form of a useful bug report.
> 
> Yes I will. But only after you stop spreading BS about how fine and
> generally dandy the situation about sound support in Linux is thanks  
> to ALSA.

I'm not spreading BS, I'm trying to identify the real problems and get
them fixed.  Unfortunately people like to bitch and moan a lot more than
they like to report bugs.

> One reports bugs only if one expects that the situation will improve.

Um, look at the alsa-devel archives or the ALSA CVS commit mailing list.
We close dozens of bugs each week.  I personally closed more than 50
last week (most had been fixed months ago).  90% of ALSA development
happens through the bug tracker.

> Glaring problems on average commodity hardware one expect the  
> developers to take
> care of without any notice.
> 

HAHA, "average commodity hardware", that's a good one.  I think you
VASTLY underestimate the difficulty of maintaining good ALSA drivers.
There are hundreds of times more sound chipset/codec combinations than
there are ALSA developers.  This is not like network or disk controller
drivers where having the datasheet is the norm - in ALSA reverse
engineered drivers are the norm and there can be dozens of variations on
a single chipset all of which the driver must handle.  It would be one
thing if the vendors helped but they don't - sound is considered desktop
stuff and they don't consider the Linux desktop market worth their time.

> However since the beginning the situation with ALSA has always been a  
> lot of
> advertisement how well it will work but the results where always less  
> then stellar
> if one looked at them from the functional side. 
> 

Check out the linux-audio-dev and linux-audio-user archives.  ALSA has
been working perfectly for all of those users for years.

Lee 

