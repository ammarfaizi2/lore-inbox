Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267899AbUGaCdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267899AbUGaCdi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 22:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267900AbUGaCdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 22:33:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59051 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267899AbUGaCde (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 22:33:34 -0400
Message-ID: <410B0486.6060706@bitplanet.net>
Date: Sat, 31 Jul 2004 04:31:34 +0200
From: =?UTF-8?B?S3Jpc3RpYW4gSMO4Z3NiZXJn?= <krh@bitplanet.net>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Olav Kongas <olav@enif.ee>, linux-kernel@vger.kernel.org
Subject: Re: input system: EVIOCSABS(abs) ioctl disabled, why?
References: <Pine.LNX.4.58.0407281453560.16069@serv.enif.ee> <20040728134313.GB4831@ucw.cz>
In-Reply-To: <20040728134313.GB4831@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Wed, Jul 28, 2004 at 03:41:28PM +0300, Olav Kongas wrote:
> 
> 
>>When trying to feed calibration information to a touchscreen driver with
>>the EVIOCSABS(abs) ioctl command, I noticed that this command is disabled
>>in 2.6.7. Only after the modification given in the patch below it was
>>possible to use this ioctl command.
>>
>>Why is the EVIOCSABS command disabled? I cannot imagine that nobody uses
> 
> 
> It's a bug. I'll fix it.

On a related note - shouldn't there also be a EVIOCSLED, or am I missing 
something obvious?  How do you set keyboard LEDs?

Kristian

