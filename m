Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752005AbWHNLf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbWHNLf6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 07:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbWHNLf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 07:35:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:224 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752005AbWHNLf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 07:35:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=gLOkTjnHPlbDugpK6tGvcxbdR8htBMhInA72GYtSVWUU/R2ZpCWPkDHH2WAsmTeF2cEsqeNuTWZZ1gfMCsJ91qF/e4SHfXHbKR13HlbcgSfFU3n9BNsLE5PmLq/oVPV7j3nfPL7P+W24o1RWeNUHwVk05KdmtNOTD15wER4Yhks=
Message-ID: <44E0601A.8050607@gmail.com>
Date: Mon, 14 Aug 2006 13:35:54 +0200
From: Maciej Rutecki <maciej.rutecki@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Dmitry Torokhov <dtor@mail.ru>
Subject: Re: 2.6.18-rc4-mm1
References: <20060813012454.f1d52189.akpm@osdl.org> <20060813121126.b1dc22ee.akpm@osdl.org> <62F8B56A.8000908@gmail.com> <200608141112.04281.rjw@sisk.pl>
In-Reply-To: <200608141112.04281.rjw@sisk.pl>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki napisał(a):
> On Sunday 14 August 2022 10:42, Maciej Rutecki wrote:
>>
>> I try this patch, keyboard works, but I have other problem. When I try:
>>
>> echo "standby" > /sys/power/state
>>
>> system goes to standby, but keyboard stop working and CMOS clock was
>> corrupted (randomize date and time e.g. Fri Feb 18 2028 13:57:43). So I
>> must reset computer.
> 
> To fix the CMOS clock problem please try to unset CONFIG_PM_TRACE .


Thanks for help, CMOS clock works correct now. But still is problem with
keyboard after standby.

Greetings
-- 
Maciej Rutecki <maciej.rutecki@gmail.com>
http://www.unixy.pl
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
