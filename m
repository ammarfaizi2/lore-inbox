Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267697AbUGaPYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267697AbUGaPYA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 11:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267961AbUGaPX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 11:23:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43200 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267697AbUGaPXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 11:23:50 -0400
Message-ID: <410BB8F9.30900@bitplanet.net>
Date: Sat, 31 Jul 2004 17:21:29 +0200
From: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@bitplanet.net>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Olav Kongas <olav@enif.ee>, linux-kernel@vger.kernel.org
Subject: Re: input system: EVIOCSABS(abs) ioctl disabled, why?
References: <Pine.LNX.4.58.0407281453560.16069@serv.enif.ee> <20040728134313.GB4831@ucw.cz> <410B0486.6060706@bitplanet.net> <20040731093353.GA1579@ucw.cz>
In-Reply-To: <20040731093353.GA1579@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
...
>>On a related note - shouldn't there also be a EVIOCSLED, or am I missing 
>>something obvious?  How do you set keyboard LEDs?
> 
> You write() an LED event to the device. EVIOCSABS is intended for
> modifying the absolute valuator range, not the value itself.

Yeah, that works, thanks.

Kristian
