Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293366AbSCAQsQ>; Fri, 1 Mar 2002 11:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293373AbSCAQrw>; Fri, 1 Mar 2002 11:47:52 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:6585 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S293366AbSCAQr2>; Fri, 1 Mar 2002 11:47:28 -0500
Date: Fri, 1 Mar 2002 17:47:24 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: John Weber <john.weber@linuxhq.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.6-pre2 and ALSA Sound
Message-ID: <20020301164724.GB31210@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	John Weber <john.weber@linuxhq.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3C7F321B.2040603@linuxhq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C7F321B.2040603@linuxhq.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 02:47:39AM -0500, John Weber wrote:

> Anyone else having trouble with ALSA YMFPCI?  Everything compiles, but I 
> can't hear a thing (even with OSS compatibility enabled).

It does work for me at least, on a VAIO C1VE, kernel 2.5.6-pre2.

lspci:
	00:09.0 Multimedia audio controller: Yamaha Corporation YMF-754 [DS-1E Audio Controller]

.config:
	CONFIG_SND=m
	CONFIG_SND_SEQUENCER=m
	CONFIG_SND_OSSEMUL=y
	CONFIG_SND_MIXER_OSS=m
	CONFIG_SND_PCM_OSS=m
	CONFIG_SND_SEQUENCER_OSS=m

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
