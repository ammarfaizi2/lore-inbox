Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbTLJCDJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 21:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbTLJCDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 21:03:09 -0500
Received: from CPE-65-30-34-80.kc.rr.com ([65.30.34.80]:45958 "EHLO
	cognition.home.hanaden.com") by vger.kernel.org with ESMTP
	id S262127AbTLJCDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 21:03:07 -0500
Message-ID: <3FD67ECE.4010707@hanaden.com>
Date: Tue, 09 Dec 2003 20:02:54 -0600
From: hanasaki <hanasaki@hanaden.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031204 Thunderbird/0.4RC1
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: VT82C686  - no sound
References: <3FD54817.9050402@hanaden.com> <20031209101808.GA18309@stud.fit.vutbr.cz> <200312091651.27677.kiza@gmx.net>
In-Reply-To: <200312091651.27677.kiza@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm I think you are saying I have all the right things loaded?  So why 
does esd run but not make startup beeps and gnome makes no sounds and 
alsa play makes no sounds?

using kernel 2.6test11

Oliver Feiler wrote:
> On Tuesday 09 December 2003 11:18, David Jez wrote:
> 
> 
>>>== /etc/modules ==
>>>snd_via82xx
>>>snd_ac97_codec
>>>snd_pcm_oss
>>>snd_page_alloc
>>>snd_pcm
>>>snd_timer
>>>snd_mixer_oss
>>>snd_pcm_oss
>>>snd_mpu401_uart
>>
>>  This is not ALSA modules. If you have configured system for use with
>>ALSA, you don't have to use OSS modules. Use ALSA with OSS emulaton
>>instead. It should works.
> 
> 
> But this _is_ ALSA with the OSS emulation modules loaded (snd_mixer_oss and 
> snd_pcm_oss). :)
> The OSS driver module is called via82cxxx_audio afaik.
> 
> Bye,
> Oliver
> 
