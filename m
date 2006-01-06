Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbWAFJyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbWAFJyR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 04:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWAFJyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 04:54:17 -0500
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:60429 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S1752155AbWAFJyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 04:54:16 -0500
Message-ID: <43BE3E3D.7050506@superbug.demon.co.uk>
Date: Fri, 06 Jan 2006 09:54:05 +0000
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hannu Savolainen <hannu@opensound.com>
CC: Marcin Dalecki <martin@dalecki.de>, Jesper Juhl <jesper.juhl@gmail.com>,
       Lee Revell <rlrevell@joe-job.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Takashi Iwai <tiwai@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Tomasz Torcz <zdzichu@irc.pl>,
       Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
References: <20050726150837.GT3160@stusta.de> <F082489C-B664-472C-8215-BE05875EAF7D@dalecki.de> <Pine.LNX.4.61.0601051154500.21555@yvahk01.tjqt.qr> <0D76E9E1-7FB0-41FD-8FAC-E4B3C6E9C902@dalecki.de> <1136486021.31583.26.camel@mindpipe> <E09E5A76-7743-4E0E-9DF6-6FB4045AA3CF@dalecki.de> <1136491503.847.0.camel@mindpipe> <7B34B941-46CC-478F-A870-43FE0D3143AB@dalecki.de> <1136493172.847.26.camel@mindpipe> <8D670C39-7B52-407C-8BDD-3478DB172641@dalecki.de> <9a8748490601051535s5e28fd81of6814088db7ccac@mail.gmail.com> <A1ECA9D1-29EB-4C44-A343-87B5EAAD4ADA@dalecki.de> <Pine.LNX.4.61.0601060302370.29362@zeus.compusonic.fi>
In-Reply-To: <Pine.LNX.4.61.0601060302370.29362@zeus.compusonic.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hannu Savolainen wrote:
> 
> Btw, about the current OSS drivers in the kernel. They are really obsolete 
> because they are based on some 10 years old API version. For this reason 
> it's necessary to remove them in the nearish future (maybe at the same 
> time when we release the OpenOSS version). Comparing ALSA against the 
> kernel OSS drivers is pointless because current OSS has very little 
> common with that code.

Hannu,

This is the LKML. So, we are considering KERNEL code. Not some external 
binary blob. We are therefore suggesting to remove the kernel OSS 
drivers as that is all we have to compare with ALSA.
We can't compare a binary blob with open source as the binary blob will 
never be part of mainline.
Even you admit that the OSS drivers in the kernel mainline are "really 
obsolete", so you must agree with this thread that we should remove them.

Only if your binary blobs are released as GPL so that they can be 
included in mainline can it really be any use to discuss them.

James
