Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVBRPRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVBRPRc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 10:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVBRPRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 10:17:32 -0500
Received: from adsl-69-149-197-17.dsl.austtx.swbell.net ([69.149.197.17]:41354
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S261208AbVBRPR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 10:17:29 -0500
Message-ID: <4216068E.90205@microgate.com>
Date: Fri, 18 Feb 2005 09:15:26 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paulo Marques <pmarques@grupopie.com>
CC: franck.bui-huu@innova-card.com, linux-kernel@vger.kernel.org
Subject: Re: [TTY] 2 points seems strange to me.
References: <20050217175150.D8E015B874@frankbuss.de> <20050217181241.A22752@flint.arm.linux.org.uk> <4215B5AC.4050600@innova-card.com> <42160290.3070000@microgate.com> <421604DD.4080809@grupopie.com>
In-Reply-To: <421604DD.4080809@grupopie.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo Marques wrote:
> Paul Fulghum wrote:
>> No, it limits the size to 80 bytes,
>> which is the size of buf.
>>
>> sizeof returns the size of the char array buf[80]
>> (standard C)
> 
> Looking at the code, I think Franck is right. buf is a "const unsigned 
> char *" for which sizeof(buf) is the size of a pointer.

What kernel version are you looking at?
I'm looking at 2.4.20 n_tty.c opost_block() and
buf is a char array.

-- 
Paul Fulghum
Microgate Systems, Ltd.
