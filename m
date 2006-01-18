Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbWARNTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbWARNTg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 08:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWARNTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 08:19:36 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:26522 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S932532AbWARNTg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 08:19:36 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Wed, 18 Jan 2006 14:19:28 +0100
To: Dominik Karall <dominik.karall@gmx.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: snd_pcm_format_name() problems [Re: 2.6.16-rc1-mm1]
References: <20060118005053.118f1abc.akpm@osdl.org>
In-Reply-To: <200601181155.59843.dominik.karall@gmx.net>
Message-Id: <20060118131928.4050622B77C@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Karall wrote:
>On Wednesday, 18. January 2006 09:50, Andrew Morton wrote:
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.
>>6.16-rc1-mm1/
>
>  LD      .tmp_vmlinux1
>sound/built-in.o:(__ksymtab+0x670): undefined reference to 
>`snd_pcm_format_name'
>make: *** [.tmp_vmlinux1] Fehler 1
>
>If needed, I can provide my config as well.
Nope.
You can use these patches (they are in alsa tree yet) or enable `Verbose procfs
contents in config' for the time being.
http://kernel.org/git/?p=linux/kernel/git/perex/alsa-current.git;a=commit;h=e91dc6f893662674f1b224cd4948b8b9f5fb9439

regards,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
