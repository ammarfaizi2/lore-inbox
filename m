Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264973AbTFQVBT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 17:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264972AbTFQVBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 17:01:19 -0400
Received: from main.gmane.org ([80.91.224.249]:17900 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264971AbTFQVBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 17:01:15 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: 2.5.71 compile error on alpha
Date: 17 Jun 2003 23:20:51 +0200
Message-ID: <yw1xptlcs8ng.fsf@zaphod.guide>
References: <3EEE4A14.4090505@g-house.de> <wrpr85te3fa.fsf@hina.wild-wind.fr.eu.org> <3EEF585E.9030404@g-house.de> <yw1xk7bk36hw.fsf@zaphod.guide> <20030617202221.GH6353@lug-owl.de> <3EEF7B20.5030208@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Kujau <evil@g-house.de> writes:

> >>That's typical for the slower Avantis.  Is your's something like 100 MHz?
> > Well, that's mainly a question of compiler version and the quantity
> > of
> > modules you attempt to build...
> 
> it's both :-)
> 
> lila:~# cat /proc/cpuinfo
> cpu			: Alpha
> cpu model		: EV45
> cpu variation		: 7
> cpu revision		: 0
> cpu serial number	:
> system type		: Avanti
> system variation	: 0
> system revision		: 0
> system serial number	:
> cycle frequency [Hz]	: 232018561
> timer frequency [Hz]	: 1024.00
> page size [bytes]	: 8192
> phys. address bits	: 34
> max. addr. space #	: 63
> BogoMIPS		: 458.36
> kernel unaligned acc	: 32 (pc=fffffc0000478394,va=fffffc0002dbf176)

That's not good.  Do you know what is causing it.

> user unaligned acc	: 0 (pc=0,va=0)
> platform string		: AlphaStation 255/233

I use one of those for a firewall/router.

> cpus detected		: 1


-- 
Måns Rullgård
mru@users.sf.net

