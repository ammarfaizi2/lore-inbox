Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWAVR7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWAVR7f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 12:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWAVR7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 12:59:34 -0500
Received: from znsun1.ifh.de ([141.34.1.16]:36561 "EHLO znsun1.ifh.de")
	by vger.kernel.org with ESMTP id S1751303AbWAVR7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 12:59:34 -0500
Date: Sun, 22 Jan 2006 18:51:15 +0100 (CET)
From: Patrick Boettcher <patrick.boettcher@desy.de>
X-X-Sender: pboettch@pub2.ifh.de
To: Michael Krufky <mkrufky@gmail.com>
Cc: Adrian Bunk <bunk@stusta.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org,
       johannes Stezenbach <js@linuxtv.org>
Subject: Re: [RFC: 2.6 patch] drivers/media/dvb/: possible cleanups
In-Reply-To: <43D3C38C.3060100@gmail.com>
Message-ID: <Pine.LNX.4.64.0601221844170.1381@pub2.ifh.de>
References: <20060122171022.GA10003@stusta.de> <43D3C38C.3060100@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Report: ALL_TRUSTED,AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 22 Jan 2006, Michael Krufky wrote:
> Patrick, please let us know where you stand on this.   Can we apply this now?

It is just about this:

>> drivers/media/dvb/dvb-usb/dvb-usb-firmware.c |    8 +++--
>> drivers/media/dvb/dvb-usb/dvb-usb.h          |    1

>> -int dvb_usb_get_hexline(const struct firmware *fw, struct hexline *hx, int 
>> *pos)
>> +static int dvb_usb_get_hexline(const struct firmware *fw, struct hexline 
>> *hx,
>> +			       int *pos)

>> -extern int dvb_usb_get_hexline(const struct firmware *, struct hexline *, 
>> int *);

But I don't care much... Just another change I have to re-commit 
afterwards. Just apply it.

regards,
Patrick.

--
   Mail: patrick.boettcher@desy.de
   WWW:  http://www.wi-bw.tfh-wildau.de/~pboettch/
