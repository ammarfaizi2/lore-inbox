Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbWHQN3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbWHQN3z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbWHQN3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:29:54 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:3800
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S964949AbWHQN3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:29:47 -0400
Message-ID: <44E46F3B.9050000@microgate.com>
Date: Thu, 17 Aug 2006 08:29:31 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, Raphael Hertzog <hertzog@debian.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: How to avoid serial port buffer overruns?
References: <20060816104559.GF4325@ouaza.com>	 <1155753868.3397.41.camel@mindpipe> <44E37095.9070200@microgate.com>	 <1155762739.7338.18.camel@mindpipe>	 <1155767066.2600.19.camel@localhost.localdomain>	 <20060816231033.GB12407@flint.arm.linux.org.uk>	 <1155806446.15195.42.camel@localhost.localdomain>	 <20060817092811.GA28474@flint.arm.linux.org.uk> <1155815832.15195.80.camel@localhost.localdomain>
In-Reply-To: <1155815832.15195.80.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Raphael said "I forgot to mention the kind of UART in my mail but it is
> a 16650A"

There are two different applications reporting
problems in this one thread.

Lee's friend is the only one using MIDI,
Raphael is having problems with regular
serial communications.

Both are receive problems that started
with the 2.6 series, but may or may not be
the same problem. Lee is reporting lost data
and Raphael is reporting rx overruns.

I asked Lee to clarify which driver his friend is
using (the MIDI 16550 or standard serial 8250).
His original post stated "a serial MIDI card (supported
by the bog standard 8250 serial driver)".

-- 
Paul Fulghum
Microgate Systems, Ltd.
