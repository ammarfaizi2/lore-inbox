Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266014AbUAEXSc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 18:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266018AbUAEXSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 18:18:32 -0500
Received: from hell.org.pl ([212.244.218.42]:7696 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S266014AbUAEXS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 18:18:27 -0500
Date: Tue, 6 Jan 2004 00:18:33 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-mm2] PM timer still has problems
Message-ID: <20040105231833.GA12844@hell.org.pl>
References: <20031230204831.GA17344@hell.org.pl> <1073340716.15645.96.camel@cog.beaverton.ibm.com> <20040105221758.GA13727@hell.org.pl> <1073341969.15645.106.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <1073341969.15645.106.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote john stultz:
> Ah, I must have missed that point. Indeed that is very odd. When booting
> without the clock= what time source is used? Does booting w/
> "clock=crazy" also show the problem?

A quick follow-up: booting with 2.6.1-rc1 + plus your patch:
clock=crazy: doesn't even pass the Uncompressing kernel... Booting Linux 
             stage,
clock=pmtmr: see above
clock=tsc  : boots normally
clock=pit  : as well

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
