Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVCUDV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVCUDV6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 22:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVCUDV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 22:21:57 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:17020 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261527AbVCUDVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 22:21:42 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Patrick McFarland <pmcfarland@downeast.net>
Subject: Re: alsa es1371's joystick functionality broken in 2.6.11-mm4
Date: Sun, 20 Mar 2005 22:21:37 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <200503201557.58055.pmcfarland@downeast.net> <20050320163900.75f30a9f.akpm@osdl.org> <200503202104.46144.pmcfarland@downeast.net>
In-Reply-To: <200503202104.46144.pmcfarland@downeast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503202221.37576.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 March 2005 21:04, Patrick McFarland wrote:
> On Sunday 20 March 2005 07:39 pm, Andrew Morton wrote:
> > Patrick McFarland <pmcfarland@downeast.net> wrote:
> > > It seems that the es1371 driver (which provides its own joystick port
> > > driver) is broken in at least 2.6.11-mm4. I don't know when it broke, but
> > > it used to work around in the 2.6.8/9 days (I haven't used the joystick
> > > in awhile). The hardware and joystick still both work (tested in
> > > Windows).
> >
> > Please define "broken".  I assume that audio still comes out, but that the
> > joystick doesn't work?
> 
> Yup, audio works fine, this is why I never noticed. Also, the external midi 
> interface also works fine. Digging around, /proc/asound/card0/audiopci says 
> "Joystick enable: off, Joystick port: 0x200". 
> 
> I've also been looking through alsa's cvs for alsa-kernel, and I can't see any 
> changes that might have broken it.
> 

I could have broken it during my gameport sysfs integration... Although I can't
see anything that could cause the breakage. Can I please see your .config?

-- 
Dmitry
