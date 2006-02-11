Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWBKN4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWBKN4K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 08:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWBKN4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 08:56:10 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:23101 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932289AbWBKN4I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 08:56:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WdqjRIbKuY7ti7UQGfWUUFT6eDUd/t4UtuvqSQly6DPaUUSkAtpyfjSiVtgKTaS7wnNHO2k1NAHaTPL3hgytJM+hv5HOQ0Ths3LNxsCY3o+jBHn89WpUsZh2NJ7kGv38g2SLV1AxsqKRLMWl8CeEzEHZpNGQMyjqZnzcsegHt7g=
Message-ID: <7c3341450602110556u75c4bfffq@mail.gmail.com>
Date: Sat, 11 Feb 2006 13:56:07 +0000
From: Nick <nick@linicks.net>
Reply-To: Nick <nick@linicks.net>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [Alsa-devel] Re: ALSA - pnp OS bios option
Cc: Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org,
       alsa-devel@lists.sourceforge.net
In-Reply-To: <200602111054.50947.nick@linicks.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601092022.56244.nick@linicks.net>
	 <200601101759.20707.nick@linicks.net> <s5hek3geyup.wl%tiwai@suse.de>
	 <200602111054.50947.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ummm.  At the command line, same errors also.  So I deleted /etc/asound.state
> and reconfigured alsamixer from scratch.  Then following 'alsactl store',
> 'alsactl restore' completes without issue (i.e. works clean).
>
> If I then reboot, the same damn control #47 errors happen again.  It's as if
> something changes my asound.state file at boot time time?
>
> Ideas?  This is driving me potty.
>

OK, talking to myself (testing, testing, 1-2-3) - I have resolved this
issue after spending 2 hours trying to get my Mic to work again in
Teamspeak (why is there _so_ many frigging mixers
(alsamixer/amixer/aumix/kmix/arts) that all seem to do different
things...

I updated alsa-lib and alsa-utils to1.0.11rc3/rc2   This fixed my issues.

Now the question - there have been a lot of alsa changes (since my
alsa-tools was built Slack 10) - do we need to keep the alsa tools and
stuff current too?

Nick
