Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbWGaAsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbWGaAsj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 20:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWGaAsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 20:48:38 -0400
Received: from [210.76.114.181] ([210.76.114.181]:14000 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S932489AbWGaAsh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 20:48:37 -0400
Message-ID: <44CD536C.3050703@ccoss.com.cn>
Date: Mon, 31 Jul 2006 08:48:44 +0800
From: liyu <liyu@ccoss.com.cn>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Peter <peter@maubp.freeserve.co.uk>,
       The Doctor <thedoctor@tardis.homelinux.org>
Subject: Re: [PATCH 1/3] usbhid: Driver for microsoft natural ergonomic keyboard
 4000
References: <44C74708.6090907@ccoss.com.cn> <20060728135428.GC4623@ucw.cz>
In-Reply-To: <20060728135428.GC4623@ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek Wrote:
> Hi!
>
>   
>>     This new version get some improvements:
>>
>>     2. Support left paren key "(", right paren key ")", equal key "=" on
>> right-top keypad. In fact, this keyboard generate KEYPAD_XXX usage code
>> for them, but I find many applications can not handle them on default
>> configuration, especially X.org. To get the most best usability, I use a
>> bit magic here: map them to "Shift+9" and "Shift+0".
>>     
>
> That is hardly 'improvement'. 'X is broken, so lets break input, too'.
>
>
>
>   
Well, however, this can work truly. If we do not hack as this way.
Many applications can not get its input. I think the usability for
most people should be first, but not follow rules.

I think we can add one module parameter like "shift_hack" to switch it ?!


