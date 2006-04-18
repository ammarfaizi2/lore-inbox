Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWDRWY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWDRWY3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 18:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWDRWY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 18:24:29 -0400
Received: from smtpout.mac.com ([17.250.248.178]:17891 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750732AbWDRWY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 18:24:28 -0400
In-Reply-To: <44453EB6.4060907@sh.cvut.cz>
References: <4443EED9.30603@sh.cvut.cz> <200604180254.47827.arnd@arndb.de> <44453EB6.4060907@sh.cvut.cz>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <46C8B7BA-4112-4F57-B7E0-BF5912D742D4@mac.com>
Cc: Arnd Bergmann <arnd@arndb.de>, wim@iguana.be, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Mark Rustad <mrustad@mac.com>
Subject: Re: [RFC] Watchdog device class
Date: Tue, 18 Apr 2006 17:24:08 -0500
To: Rudolf Marek <r.marek@sh.cvut.cz>
X-Mailer: Apple Mail (2.749.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 18, 2006, at 2:32 PM, Rudolf Marek wrote:

>> What's the point in having more than one watchdog active?
>> If you want more than one, why hardcode a specific limit?
>
> I thought there might be such future need, nowdays it used
> to test the stuff.
>
> If nobody here wants it I have no problem to change the class just  
> to allow
> one active watchdog.

Actually, I have a case right now. For us, a watchdog with minute  
granularity is just too long, but that is the only hardware watchdog  
available. So, we use softdog for finer granularity and the  
additional crappy hardware watchdog just to catch cases that softdog  
doesn't. I just wanted to pass along an example where more than one  
watchdog is needed for your consideration.

-- 
Mark Rustad, MRustad@mac.com

