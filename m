Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752028AbWJAGDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbWJAGDQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 02:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbWJAGDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 02:03:16 -0400
Received: from gw.goop.org ([64.81.55.164]:34787 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1752028AbWJAGDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 02:03:10 -0400
Message-ID: <451F5A1C.2060201@goop.org>
Date: Sat, 30 Sep 2006 23:03:08 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alsa-devel@alsa-project.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18: hda_intel: azx_get_response timeout, switching to single_cmd
 mode...
References: <451834D0.40304@goop.org> <s5hlko7szjy.wl%tiwai@suse.de>
In-Reply-To: <s5hlko7szjy.wl%tiwai@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
> You must see difference with mm1 (suppose that mm1 already includes
> the latest ALSA patches).  When the CORB/RIRB interrupt gets broken,
> the driver first switches to poling mode, then single_cmd mode as
> fallback.
>   

I tried -mm2, and I'm seeing the same problem.

> Also, try disable_msi=1 option for mm1.  MSI seems broken on some
> systems.
>   

This made no difference.

    J
