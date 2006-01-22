Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWAVSMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWAVSMS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 13:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWAVSMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 13:12:18 -0500
Received: from thing.hostingexpert.com ([67.15.235.34]:58046 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1751303AbWAVSMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 13:12:17 -0500
Message-ID: <43D3CAFF.5070507@gmail.com>
Date: Sun, 22 Jan 2006 13:12:15 -0500
From: Michael Krufky <mkrufky@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Boettcher <patrick.boettcher@desy.de>
CC: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
Subject: Re: [linux-dvb-maintainer] Re: [RFC: 2.6 patch] drivers/media/dvb/:
 possible cleanups
References: <20060122171022.GA10003@stusta.de> <43D3C38C.3060100@gmail.com> <Pine.LNX.4.64.0601221844170.1381@pub2.ifh.de>
In-Reply-To: <Pine.LNX.4.64.0601221844170.1381@pub2.ifh.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - gmail.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Boettcher wrote:

> Hi,
>
> On Sun, 22 Jan 2006, Michael Krufky wrote:
>
>> Patrick, please let us know where you stand on this.   Can we apply 
>> this now?
>
> It is just about this:
>
>>> drivers/media/dvb/dvb-usb/dvb-usb-firmware.c |    8 +++--
>>> drivers/media/dvb/dvb-usb/dvb-usb.h          |    1
>>
>>> -int dvb_usb_get_hexline(const struct firmware *fw, struct hexline 
>>> *hx, int *pos)
>>> +static int dvb_usb_get_hexline(const struct firmware *fw, struct 
>>> hexline *hx,
>>> +                   int *pos)
>>
>>> -extern int dvb_usb_get_hexline(const struct firmware *, struct 
>>> hexline *, int *);
>>
> But I don't care much... Just another change I have to re-commit 
> afterwards. Just apply it.

Applied to cvs.

Thank you, Adrian. :-)

Cheers,

Michael Krufky
