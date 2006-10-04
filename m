Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWJDUIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWJDUIO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 16:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWJDUIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 16:08:14 -0400
Received: from gw.goop.org ([64.81.55.164]:43720 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751027AbWJDUIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 16:08:13 -0400
Message-ID: <4524149C.6090107@goop.org>
Date: Wed, 04 Oct 2006 13:07:56 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alsa-devel@alsa-project.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18: hda_intel: azx_get_response timeout, switching to single_cmd
 mode...
References: <451834D0.40304@goop.org>	<s5hlko7szjy.wl%tiwai@suse.de>	<451F5A1C.2060201@goop.org>	<s5hk63gl9mp.wl%tiwai@suse.de>	<4523D041.8000400@goop.org> <s5hpsd7j42j.wl%tiwai@suse.de>
In-Reply-To: <s5hpsd7j42j.wl%tiwai@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
> A counter of RIRB pending commands could overflow the size of RIRB 
> when a bunch of commands are sent but not synced.  This may lead to
> the azx_get_response error, theoretically.
>
> Could you apply the patch below and check what values are shown there?
>   
I'll try it, but I re-enabled the modem in the bios, and I no longer get 
this message and it appears to work (there seems to be a secondary 
problem that the volume hotkeys have stopped working, but I suspect 
that's more ACPI-related).

    J
