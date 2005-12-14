Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbVLNNEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbVLNNEX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 08:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbVLNNEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 08:04:23 -0500
Received: from relay4.usu.ru ([194.226.235.39]:6343 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S932219AbVLNNEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 08:04:22 -0500
Message-ID: <43A0181C.10205@ums.usu.ru>
Date: Wed, 14 Dec 2005 18:03:24 +0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Kenneth.Parrish@familynet-international.net
Subject: Re: [SERIAL, -mm] CRC failure
References: <403eda.8e05b5@familynet-international.net> <1134551256.25663.3.camel@localhost.localdomain>
In-Reply-To: <1134551256.25663.3.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.33.0.11; VDF: 6.33.0.25; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2005-12-14 at 06:45 +0000, Kenneth Parrish wrote:
> 
>>        Three -mm kernels of late, and now v2.6.15-rc5-mm2, give
>>frequent z-modem crc errors with minicom, lrz, and an external v90 modem
>>to a couple of local bb's.  2.6.15-rc5-git2 and before are okay.
> 
> 
> 
> Which -mm kernels gave the error, and which do you know ehrre ok. Also
> can you tell me more about the hardware arrangement you are using - what
> cpu, what serial driver ?
> 
> The -mm tree contains some buffering changes I made and those would be
> the obvious candidate for suspicion

Please CC: me on all replies to this thread, because I think this is 
also related to the ppp failures (a packet repeating over and over) that 
I reported earlier on -mm kernels.

-- 
Alexander E. Patrakov
