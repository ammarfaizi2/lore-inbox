Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbTJWVGE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 17:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbTJWVGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 17:06:03 -0400
Received: from smtp5.arnet.com.ar ([200.45.191.23]:21644 "HELO
	smtp5.arnet.com.ar") by vger.kernel.org with SMTP id S261788AbTJWVGB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 17:06:01 -0400
Message-ID: <3F9842C0.10206@arnet.com.ar>
Date: Thu, 23 Oct 2003 18:06:08 -0300
From: Javier Villavicencio <jvillavicencio@arnet.com.ar>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: DuDe <dude68@tiscali.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: Radeon 9600 triplex
References: <200310232251.12780.dude68@tiscali.it>
In-Reply-To: <200310232251.12780.dude68@tiscali.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DuDe wrote:

> Hi list, i would like add 9600 radeon support on radeonfb driver, now i have 
> successfully add a limited support on radeonfb driver, but i have some 
> problem, the system boot, i see 2 penguin logo but the cursor is scared, and 
> if use fbset to set resolution, i cant get resolution function but only a 
> square area of the crt are in hires, the rest is dirty.
> 
> Where i can find infos about howto add support in radeonfb? 
> 
> Many thanks 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

I did something similar taking parts of the radeonfb driver from 
2.4.23-preX (maybe 6) into 2.6, hard coding the resolution into the code 
I have 1024x768 and a ugly big cursor on console, fbtv and links on 
framebuffer works fine, but when I switch back from XFree (using fglrx 
drivers from ati) the console is completely unusable no matter what can 
I do with fbset (seems that I missed some clock setting for the RV350).

So the very first source of support for 9600 is the working driver on 2.4.23

Greetings

Javier Villavicencio.

