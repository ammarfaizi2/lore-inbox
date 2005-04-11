Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbVDKHRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVDKHRA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 03:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVDKHRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 03:17:00 -0400
Received: from [151.12.57.13] ([151.12.57.13]:44813 "EHLO
	mail2.it.atosorigin.com") by vger.kernel.org with ESMTP
	id S261713AbVDKHQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 03:16:57 -0400
From: Rao Davide <davide.rao@atosorigin.com>
To: Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org, ink@jurassic.park.msu.ru
Message-ID: <425A2442.8090607@atosorigin.com>
Date: Mon, 11 Apr 2005 09:16:18 +0200
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: Re: Linux Alpha port: kernel panik under moderate DISK IO conditions
References: <42569BC7.5030709@atosorigin.com> <20050408190709.GB27845@twiddle.net>
In-Reply-To: <20050408190709.GB27845@twiddle.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Apr 2005 07:22:47.0140 (UTC) FILETIME=[42B15A40:01C53E67]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not using the qlogic controller as boot controller. I'm mooting from 
the internal disk connected to LSI controller.
In any case I'll try out the suggested 1280  right now.

Can I build a modular kernel with the 2.6 kernel series ?
I would find it handy to have som parts colpiled as modules.

--
Regards
Davide Rao
   Client/server Unix
   Atos Origin
   Via C.Viola - Pont St. Martin (AO) Italy
   Cell :  +39 3357599151
   Tel  :  +39 125810433
   Email:  davide.rao@atosorigin.com


Richard Henderson wrote:
> On Fri, Apr 08, 2005 at 04:57:11PM +0200, Rao Davide wrote:
> 
>>My name is David Rao and I have an old alpha DS10 ds10 (ev6 
>>Tsunami-webbrick cpu) with internal HDU on a LSI controller and external 
>>HSZ80 storage attached to a Qlogic.
> 
> 
> Well, the CONFIG_SCSI_QLOGIC_ISP driver isn't supported, and you
> may have noticed prints big warning messages when you boot with it.
> 
> Fortunately, the CONFIG_SCSI_QLOGIC_1280 driver has been extended
> to handle the 1020 and 1040 devices.  I've been using that for a
> while now on my ds10.
> 
> 
> r~
