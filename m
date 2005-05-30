Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVE3JmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVE3JmE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 05:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVE3JlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 05:41:07 -0400
Received: from znsun1.ifh.de ([141.34.1.16]:44257 "EHLO znsun1.ifh.de")
	by vger.kernel.org with ESMTP id S261580AbVE3Jiw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 05:38:52 -0400
Date: Mon, 30 May 2005 11:30:37 +0200 (CEST)
From: Patrick Boettcher <pb@linuxtv.org>
X-X-Sender: pboettch@pub6.ifh.de
To: Johannes Stezenbach <js@linuxtv.org>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5-mm1: drivers/media/dvb/dvb-usb/a800.c compile error
In-Reply-To: <20050530091434.GA5669@linuxtv.org>
Message-ID: <Pine.LNX.4.61.0505301124070.11869@pub6.ifh.de>
References: <20050525134933.5c22234a.akpm@osdl.org>     <20050529144548.GC10441@stusta.de>
     <Pine.LNX.4.61.0505301024120.11869@pub6.ifh.de> <20050530091434.GA5669@linuxtv.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Report: ALL_TRUSTED,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 30 May 2005, Johannes Stezenbach wrote:
>> -	struct dvb_usb_device_description devices[];
>> +	struct dvb_usb_device_description devices[0];
>
> That can't work in this context. Did you even try to compile?

Only with gcc-2.95 and it worked...

I guess I should have tried it with gcc-3.x before sending, sorry.

regards,
Patrick.
