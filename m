Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbVGEV7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbVGEV7b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 17:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVGEVrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 17:47:04 -0400
Received: from mailhub3.nextra.sk ([195.168.1.146]:30733 "EHLO
	mailhub3.nextra.sk") by vger.kernel.org with ESMTP id S261810AbVGEVgY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 17:36:24 -0400
Message-ID: <42CAFD52.2020106@rainbow-software.org>
Date: Tue, 05 Jul 2005 23:36:18 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "=?ISO-8859-1?Q?Andr=E9_Tomt?=" <andre@tomt.net>,
       Al Boldi <a1426z@gawab.com>,
       "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>,
       "'Linus Torvalds'" <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [git patches] IDE update
References: <20050705101414.GB18504@suse.de> <42CA5EAD.7070005@rainbow-software.org> <20050705104208.GA20620@suse.de> <42CA7EA9.1010409@rainbow-software.org> <1120567900.12942.8.camel@linux> <42CA84DB.2050506@rainbow-software.org> <1120569095.12942.11.camel@linux> <42CAAC7D.2050604@rainbow-software.org> <20050705142122.GY1444@suse.de> <42CAA075.4040406@rainbow-software.org> <20050705192550.GF30235@suse.de>
In-Reply-To: <20050705192550.GF30235@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Tue, Jul 05 2005, Ondrej Zary wrote:
> 
>>oread is faster than dd, but still not as fast as 2.4. In 2.6.12, HDD 
>>led is blinking, in 2.4 it's solid on during the read.
> 
> 
> Oh, and please do test 2.6 by first setting the deadline scheduler for
> hda. I can see you are using the 'as' scheduler right now.
> 
> # echo deadline > /sys/block/hda/queue/scheduler
> 

No change, still >25 seconds.

-- 
Ondrej Zary
