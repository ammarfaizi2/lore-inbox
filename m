Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbVKMQ3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbVKMQ3P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 11:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbVKMQ3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 11:29:15 -0500
Received: from rtr.ca ([64.26.128.89]:38838 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964918AbVKMQ3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 11:29:15 -0500
Message-ID: <437769D9.2080402@rtr.ca>
Date: Sun, 13 Nov 2005 11:29:13 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: "Larry.Finger@lwfinger.net" <larry.finger@att.net>
Cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.6.15-rc1: ipw2200 still not working
References: <111320050145.2779.43769AC30008CFA600000ADB21603763169D0A09020700D2979D9D0E04@att.net>
In-Reply-To: <111320050145.2779.43769AC30008CFA600000ADB21603763169D0A09020700D2979D9D0E04@att.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry.Finger@lwfinger.net wrote:
>>Well, okay, the ipw2200 works fine if I turn off all security on the AP,
>>but the 2.6.15-rc1 version can no longer connect to my WPA/WPA2 network.
..
> I don't know if it affects you, but I was not able to get WPA working
>on my Linksys WPC54G using ndiswrapper with the 2.6.14-xxx kernels
 >until I downloaded, built and installed a new version of wpa_supplicant.

Ahh.. BINGO.  I was already using wpa_supplicant-0.4.3,
but the 2.6.15-rc1 kernel was having issues (as posted).

I've now found wpa_supplicant-0.4.6, and that has cleared things up.

Thanks!
