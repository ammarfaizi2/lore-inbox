Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264318AbTLYQBq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 11:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264320AbTLYQBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 11:01:46 -0500
Received: from [195.62.234.69] ([195.62.234.69]:9695 "EHLO mail.nectarine.info")
	by vger.kernel.org with ESMTP id S264318AbTLYQBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 11:01:45 -0500
Message-ID: <3FEB0A15.4000708@nectarine.info>
Date: Thu, 25 Dec 2003 17:02:29 +0100
From: Giacomo Di Ciocco <admin@nectarine.info>
Organization: Nectarine Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       wli@holomorphy.com
Subject: Re: 2.6.0 "Losing too many ticks!"
References: <1072321519.1742.328.camel@cube>
In-Reply-To: <1072321519.1742.328.camel@cube>
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:

> I sure wouldn't bet on that. More likely, he's simply
> losing ticks. He has a Duron processor, which is
> highly unlikely to be hooked up to some crummy
> speed-changing hardware.
> 
> I had a 1 GHz Pentium III box with the same problem.
> Linux would give up on the perfectly-correct 1 GHz
> clock source in favor of trying, and failing, to
> count 1 kHz ticks from the crummy old PIT hardware.
> Time loss got so bad that NTP would simply give up.
> IDE activity may have had something to do with it.
> 
> In his case, maybe ACPI polls something while
> interrupts are off.
> 
> 

This morning i tried Andrew Morton's kernel which implements the via-tsc-fix 
(ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0/2.6.0-mm1/broken-out/via-tsc-fix.patch)
the messages are still here (Unknown HZ value! (77) Assume 100.) but after doing 
some comparison with my home workstation which has almost the same hardware the 
speed seems to be returned on the standards.


Regards.

-- 
Giacomo Di Ciocco
Nectarine Administrator
Phone/Fax: (+39) 577663107
Web: http://www.nectarine.info
Irc: irc.nectarine.info #nectarine
Email: admin@nectarine.info (pgp.mit.edu)
