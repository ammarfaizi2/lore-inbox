Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268446AbUIQGqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268446AbUIQGqn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 02:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268411AbUIQGqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 02:46:43 -0400
Received: from mail.convergence.de ([212.227.36.84]:56808 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S268446AbUIQGqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 02:46:37 -0400
Message-ID: <414A862F.5030200@linuxtv.org>
Date: Fri, 17 Sep 2004 08:37:35 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Gerd Knorr <kraxel@bytesex.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] v4l/dvb: cx88 driver update
References: <20040916094323.GA11601@bytesex> <20040916160835.4a6cea02.akpm@osdl.org>
In-Reply-To: <20040916160835.4a6cea02.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  On 17.09.2004 01:08, Andrew Morton wrote:
> Gerd Knorr <kraxel@bytesex.org> wrote:

>>This is a major update of the cx88 driver.

> drivers/media/video/cx88/cx88-dvb.c:215: `FE_UNREGISTER' undeclared (first use in this function)
> drivers/media/video/cx88/cx88-dvb.c:215: (Each undeclared identifier is reported only once
> drivers/media/video/cx88/cx88-dvb.c:215: for each function it appears in.)
> drivers/media/video/cx88/cx88-dvb.c: In function `dvb_register':
> drivers/media/video/cx88/cx88-dvb.c:232: `FE_REGISTER' undeclared (first use in this function)
> drivers/media/video/cx88/cx88-dvb.c:294: `FE_UNREGISTER' undeclared (first use in this function)
> 
> I'll drop this one - please wholly resend it.

Currently bttv/cx88 and DVB in general get more and more interwoven.

I have been waiting for Gerd to submit his latest bttv patches, so I can 
send off my DVB patches.

Gerd's latest patch depends on my not-yet-submitted patches, so just 
simply drop this one. Gerd and I are going to coordinate this and 
resubmit it again. Ok, Gerd?

CU
Michael.
