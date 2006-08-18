Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbWHRSLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWHRSLa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 14:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWHRSLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 14:11:30 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:23177
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751461AbWHRSLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 14:11:30 -0400
Message-ID: <44E602C8.3030805@microgate.com>
Date: Fri, 18 Aug 2006 13:11:20 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Serial issue
References: <1155862076.24907.5.camel@mindpipe>	 <1155915851.3426.4.camel@amdx2.microgate.com> <1155923734.2924.16.camel@mindpipe>
In-Reply-To: <1155923734.2924.16.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> But it had no effect.
> 
> Could it be a hardware-specific bug?  After all VIA chipsets are
> notorious for interrupts not working right.
> 
> Any other suggestions?

I can't think of any. The interrupts are occurring
and being serviced. Nothing else seems to be sitting
on that interrupt. It's reaching a bit: maybe there
is some console output interfering with the
file transfer protocol, but it only occurs with
interrupt enabled because of some initial timing?
(polling mode may delay things enough to work)
What protocol is ckermit using? (zmodem, etc)

-- 
Paul Fulghum
Microgate Systems, Ltd.
