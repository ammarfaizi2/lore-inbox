Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292312AbSCDKFS>; Mon, 4 Mar 2002 05:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292315AbSCDKFJ>; Mon, 4 Mar 2002 05:05:09 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:8599 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S292312AbSCDKEw>; Mon, 4 Mar 2002 05:04:52 -0500
Date: Mon, 4 Mar 2002 11:04:50 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: John Weber <john.weber@linuxhq.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.6-pre2 and ALSA Sound
Message-ID: <20020304100450.GE25326@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	John Weber <john.weber@linuxhq.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.cgp5alv.114qq93@ifi.uio.no> <fa.hjuh5ov.l223o4@ifi.uio.no> <3C81C6C7.8030902@linuxhq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C81C6C7.8030902@linuxhq.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2002 at 01:46:31AM -0500, John Weber wrote:

> It does not work for me.  It appears to be working (the apps look like 
> they are playing an MP3, but no sound).
> 
> .config
> CONFIG_SND=y
> CONFIG_SND_OSSEMUL=y
> CONFIG_SND_MIXER_OSS=y
> CONFIG_SND_PCM_OSS=y
> CONFIG_SND_YMFPCI=y

Tried again this time compiling the drivers in the kernel (same .config
as yours) and it still works ok.

> lspci:
> Multimedia audio controller: Yamaha Corporation YMF-744B [DS-1S Audio 
> Controller] (rev 02)

Then it could be the slight chipset difference...

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
