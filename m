Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265293AbUAJSeo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 13:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265296AbUAJSeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 13:34:44 -0500
Received: from 194.149.109.108.adsl.nextra.cz ([194.149.109.108]:58777 "EHLO
	gate2.perex.cz") by vger.kernel.org with ESMTP id S265293AbUAJSen
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 13:34:43 -0500
Date: Sat, 10 Jan 2004 19:34:34 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
Subject: Re: 2.6.1 sound oops
In-Reply-To: <20040110165754.GB367@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0401101931420.1883@pnote.perex-int.cz>
References: <20040110165754.GB367@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jan 2004, Pavel Machek wrote:

> Hi!
> 
> I got following when trying to play video on 2.6.1... I remmber
> similar oops in past. Any ideas?

Try 2.6.1-mm1 and/or toggle CONFIG_FRAME_POINTER settings. It seems that
GCC has some issues with it.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
