Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbWGCLzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWGCLzp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 07:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWGCLzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 07:55:45 -0400
Received: from gate.crashing.org ([63.228.1.57]:61869 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750702AbWGCLzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 07:55:45 -0400
Subject: Re: OSS driver removal, 2nd round
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz,
       Olaf Hering <olh@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20060629192128.GE19712@stusta.de>
References: <20060629192128.GE19712@stusta.de>
Content-Type: text/plain
Date: Mon, 03 Jul 2006 21:52:59 +1000
Message-Id: <1151927579.13828.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> DMASOUND_PMAC
> - Olaf Hering regarding regressions in SND_POWERMAC:
>   Some tumbler models work only after one plug/unplug cycle of
>   the headphone. early powerbooks report/handle the mute settings
>   incorrectly. there are likely more bugs.

dmasound_pmac is crippled with bugs too... We should look at reported
bug reports on snd-powermac (and snd-aoa which replaces the later for
recent machines) and kill dmasound-pmac. I'm ok with that. snd-aoa is
the only one to be properly maintained anyway, we'll add support for
older machines to it over time and hopefully, it's a much saner codebase
in the first place so handling weird machines regressions will be
easier.

Ben.


