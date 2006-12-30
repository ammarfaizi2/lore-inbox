Return-Path: <linux-kernel-owner+w=401wt.eu-S1030337AbWL3U2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbWL3U2D (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 15:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030335AbWL3U2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 15:28:03 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:39046 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030334AbWL3U2B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 15:28:01 -0500
From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Organization: TUBITAK/UEKAE
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: No sound in KDE with intel hda since 2.6.20-rc1
Date: Sat, 30 Dec 2006 22:27:46 +0200
User-Agent: KMail/1.9.5
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-sound@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
       PeiSen Hou <pshou@realtek.com.tw>
References: <200612301844.02413.s0348365@sms.ed.ac.uk> <20061230191123.GA4352@mellanox.co.il> <200612301919.06949.s0348365@sms.ed.ac.uk>
In-Reply-To: <200612301919.06949.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612302227.48097.ismail@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

30 Ara 2006 Cts 21:19 tarihinde şunları yazmıştınız:
> On Saturday 30 December 2006 19:11, Michael S. Tsirkin wrote:
> > > On Friday 29 December 2006 06:25, Michael S. Tsirkin wrote:
> > > > Virtual MIDI Card 1
> > >
> > > Compile this feature out, I bet things start working again.
> >
> > Yes, this helped, thanks.
> > BTW, is this expected?
>
> It's a severe "misfeature" in my opinion that caused me problems years ago.
> The first soundcard becomes "default", which can probably be overridden in
> many different ways.
>
> However, I really think a hack should be put in to prevent "virtual MIDI"
> from ever being in the first slot, it's just a bug asking to happen.

So should we enable Virtual MIDI in kernel config? Since I have it off and 
aRts have no sound with ALSA backend.

Regards,
ismail

-- 
2 + 2 = 5 for very large values of 2
