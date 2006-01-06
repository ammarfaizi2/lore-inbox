Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752333AbWAFBj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbWAFBj2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 20:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752331AbWAFBj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 20:39:28 -0500
Received: from host1.compusonic.fi ([195.238.198.242]:48742 "EHLO
	minor.compusonic.fi") by vger.kernel.org with ESMTP
	id S1752202AbWAFBj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 20:39:27 -0500
Date: Fri, 6 Jan 2006 03:36:47 +0200 (EET)
From: Hannu Savolainen <hannu@opensound.com>
X-X-Sender: hannu@zeus.compusonic.fi
To: Marcin Dalecki <martin@dalecki.de>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Lee Revell <rlrevell@joe-job.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Takashi Iwai <tiwai@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Tomasz Torcz <zdzichu@irc.pl>,
       Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
In-Reply-To: <A1ECA9D1-29EB-4C44-A343-87B5EAAD4ADA@dalecki.de>
Message-ID: <Pine.LNX.4.61.0601060302370.29362@zeus.compusonic.fi>
References: <20050726150837.GT3160@stusta.de> <F082489C-B664-472C-8215-BE05875EAF7D@dalecki.de>
 <Pine.LNX.4.61.0601051154500.21555@yvahk01.tjqt.qr>
 <0D76E9E1-7FB0-41FD-8FAC-E4B3C6E9C902@dalecki.de> <1136486021.31583.26.camel@mindpipe>
 <E09E5A76-7743-4E0E-9DF6-6FB4045AA3CF@dalecki.de> <1136491503.847.0.camel@mindpipe>
 <7B34B941-46CC-478F-A870-43FE0D3143AB@dalecki.de> <1136493172.847.26.camel@mindpipe>
 <8D670C39-7B52-407C-8BDD-3478DB172641@dalecki.de>
 <9a8748490601051535s5e28fd81of6814088db7ccac@mail.gmail.com>
 <A1ECA9D1-29EB-4C44-A343-87B5EAAD4ADA@dalecki.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006, Marcin Dalecki wrote:

> 
> 
> No I do not. How do you dare to assume I do?
> I never ever did ask for any support on behalf of the ALSA bunch...
> We are just discussing the merits of one sound system design
> over another one (without design).
Which is really a good subject to discuss about (LKML may not be the right 
place for this). ALSA has been in the official kernel for two years now so 
might this be a good time to look back?

There are two very opposite approaches to do a sound subsystem. The ALSA 
way is to expose every single detail of the hardware to the applications 
and to allow (or force) application developers to deal with them. The OSS 
approach is to provide maximum device abstraction in the API level (by 
isolating the apps from the hardware as much as practically possible).

Both ways have their good and bad sides. During past years the ALSA 
advocates have been dictating that the ALSA approach is the only available 
way to go (all resistance is futile). But after all what is the authority 
who makes the final decision? Is it the ALSA team (who would like to think 
in this way)? Or do the Linux/Unix users and audio application developers 
have any word to say?

Btw, about the current OSS drivers in the kernel. They are really obsolete 
because they are based on some 10 years old API version. For this reason 
it's necessary to remove them in the nearish future (maybe at the same 
time when we release the OpenOSS version). Comparing ALSA against the 
kernel OSS drivers is pointless because current OSS has very little 
common with that code.

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM
