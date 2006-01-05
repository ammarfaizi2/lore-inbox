Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752078AbWAEHMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbWAEHMS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 02:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752076AbWAEHMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 02:12:17 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:61831 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1752074AbWAEHMQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 02:12:16 -0500
Date: Thu, 5 Jan 2006 08:11:12 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Florian Schmidt <tapas@affenbande.org>
cc: Marcin Dalecki <dalecki.marcin@neostrada.pl>, Takashi Iwai <tiwai@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Jesper Juhl <jesper.juhl@gmail.com>,
       Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
In-Reply-To: <20060104205232.1dd5f308@mango.fruits.de>
Message-ID: <Pine.LNX.4.61.0601050809200.10161@yvahk01.tjqt.qr>
References: <s5h1wzpnjrx.wl%tiwai@suse.de> <20060103203732.GF5262@irc.pl>
 <s5hvex1m472.wl%tiwai@suse.de> <9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com>
 <20060103215654.GH3831@stusta.de> <20060103221314.GB23175@irc.pl>
 <20060103231009.GI3831@stusta.de> <Pine.BSO.4.63.0601040048010.29027@rudy.mif.pg.gda.pl>
 <20060104000344.GJ3831@stusta.de> <Pine.BSO.4.63.0601040113340.29027@rudy.mif.pg.gda.pl>
 <20060104010123.GK3831@stusta.de> <Pine.BSO.4.63.0601040242190.29027@rudy.mif.pg.gda.pl>
 <20060104113726.3bd7a649@mango.fruits.de> <s5hsls398uv.wl%tiwai@suse.de>
 <20060104191750.798af1da@mango.fruits.de> <74F7C515-831F-42E4-9A6F-70A9C11E8BB3@neostrada.pl>
 <20060104205232.1dd5f308@mango.fruits.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Maybe create a /proc control, so users can revert
>> > to the olde behaviour if there really is any need.
>> 
>> YES YES! After all who doesn't use his system logged in as root?
>

There is something like /etc/init.d/boot.local in which you can set your
preference. Who changes his blocking mode behavior every day, huh?

>Well, maybe it is a bad idea. Got a better one up your sleeve? Or just
>sarcasm? 
>
>Maybe make it a .asoundrc option (which libasound reads everytime a
>device is opened anyways). Maybe even per device.
>
And what about the OSS emulation /dev/dsp? OSS apps do not read .asoundrc.


Jan Engelhardt
-- 
