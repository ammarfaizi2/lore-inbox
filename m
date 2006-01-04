Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWADUOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWADUOV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 15:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbWADUOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 15:14:21 -0500
Received: from smtpout.mac.com ([17.250.248.71]:26050 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751771AbWADUOT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 15:14:19 -0500
In-Reply-To: <Pine.LNX.4.61.0601041545580.5750@yvahk01.tjqt.qr>
References: <20050726150837.GT3160@stusta.de> <200601031522.06898.s0348365@sms.ed.ac.uk> <20060103160502.GB5262@irc.pl> <200601031629.21765.s0348365@sms.ed.ac.uk> <20060103170316.GA12249@dspnet.fr.eu.org> <s5h1wzpnjrx.wl%tiwai@suse.de> <20060103203732.GF5262@irc.pl> <s5hvex1m472.wl%tiwai@suse.de> <9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com> <20060103215654.GH3831@stusta.de> <9a8748490601031411p17d4417fyffbfee00ca85ac82@mail.gmail.com> <s5hpsn8md1j.wl%tiwai@suse.de> <Pine.LNX.4.61.0601041545580.5750@yvahk01.tjqt.qr>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <27043632-7EA6-4468-A5D9-7E90725373F3@mac.com>
Cc: Takashi Iwai <tiwai@suse.de>, Jesper Juhl <jesper.juhl@gmail.com>,
       Adrian Bunk <bunk@stusta.de>, Tomasz Torcz <zdzichu@irc.pl>,
       Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Date: Wed, 4 Jan 2006 15:12:33 -0500
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 04, 2006, at 09:46, Jan Engelhardt wrote:
>>> Still would be nice if users of ALSA who have the OSS backwards  
>>> compat
>>> enabled would thus also get transparent software mixing for all apps
>>> using the OSS API.
>>> not crucial, that's not what I'm saying, just nice if it would be  
>>> possible.
>>
>> Technicall it's trivial to implement the soft-mixing in the kernel.
>> The question is whether it's the right implementation.
>> We have a user-space softmix for ALSA, and aoss wrapper for OSS using
>> it.  (I know aoss still has some problems that should be fixed,
>> though.)
>
> Software mixing in the kernel is like FPU ops in the kernel...

Software mixing in the kernel probably _IS_ FPU ops in the kernel.   
We already do video mixing (think X) in userspace, I see no reason  
why audio should be different.

Cheers,
Kyle Moffett

--
Somone asked me why I work on this free (http://www.fsf.org/ 
philosophy/) software stuff and not get a real job. Charles Schulz  
had the best answer:

"Why do musicians compose symphonies and poets write poems? They do  
it because life wouldn't have any meaning for them if they didn't.  
That's why I draw cartoons. It's my life."
   -- Charles Schulz


