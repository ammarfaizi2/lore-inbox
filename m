Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbVIZQtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbVIZQtk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 12:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbVIZQtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 12:49:40 -0400
Received: from [85.21.88.2] ([85.21.88.2]:698 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S1751115AbVIZQtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 12:49:39 -0400
Message-ID: <433826EE.9020107@rbcmail.ru>
Date: Mon, 26 Sep 2005 20:50:54 +0400
From: Vitaly Wool <vitalhome@rbcmail.ru>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: vitalhome@rbcmail.ru, basicmark@yahoo.com, linux-kernel@vger.kernel.org,
       dpervushin@ru.mvista.com
Subject: Re: [RFC][PATCH] SPI subsystem
References: <20050910115434.32450.qmail@web30303.mail.mud.yahoo.com> <20050915001429.BC6E7EA55C@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
In-Reply-To: <20050915001429.BC6E7EA55C@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

David Brownell wrote:

>Most platform drivers I've seen just handle the power on/off
>requests.  I think there's some historical reason that the
>"reason" stuff exists ... but I suspect not many folk would
>get unhappy if that were removed, and those calls got simplified.
>  
>
No, I can't agree with you. This state machine provides useful framework 
for drivers that work with DMA and/or drivers that set their own wakeup 
bits etc. etc. It allows the driver essence to enter the state where it 
doesn't accept any new requests but is able to successfully finish the 
current ones.

Best regards,
   Vitaly
