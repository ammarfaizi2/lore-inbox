Return-Path: <linux-kernel-owner+w=401wt.eu-S1030340AbWL3UpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbWL3UpU (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 15:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030339AbWL3UpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 15:45:20 -0500
Received: from p02c11o144.mxlogic.net ([208.65.145.67]:41934 "EHLO
	p02c11o144.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030335AbWL3UpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 15:45:18 -0500
Date: Sat, 30 Dec 2006 22:45:27 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Ismail =?iso-8859-1?Q?D=F6nmez?= <ismail@pardus.org.tr>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-sound@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
       PeiSen Hou <pshou@realtek.com.tw>
Subject: Re: No sound in KDE with intel hda since 2.6.20-rc1
Message-ID: <20061230204527.GB4338@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <200612302227.48097.ismail@pardus.org.tr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612302227.48097.ismail@pardus.org.tr>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 30 Dec 2006 20:47:21.0796 (UTC) FILETIME=[B40C4840:01C72C53]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14904.000
X-TM-AS-Result: No--9.634400-4.000000-31
X-Spam: [F=0.0229331127; S=0.022(2006120601)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > Virtual MIDI Card 1
> > > >
> > > > Compile this feature out, I bet things start working again.
> > >
> > > Yes, this helped, thanks.
> > > BTW, is this expected?
> >
> > It's a severe "misfeature" in my opinion that caused me problems years ago.
> > The first soundcard becomes "default", which can probably be overridden in
> > many different ways.
> >
> > However, I really think a hack should be put in to prevent "virtual MIDI"
> > from ever being in the first slot, it's just a bug asking to happen.
> 
> So should we enable Virtual MIDI in kernel config? Since I have it off and 
> aRts have no sound with ALSA backend.

Try updating to latest git - I have 7479b1ce5ea41a828002c60739cff37f47b62913
with Virtual MIDI off and ALSA seems to work.

BTW, Amarok has an Engine dialog where you can easily switch between backends
which is good for testing.

-- 
2 + 2 = 5 for very large values of 2

-- 
MST
