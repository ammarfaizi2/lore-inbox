Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291719AbSBTK0O>; Wed, 20 Feb 2002 05:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291720AbSBTK0F>; Wed, 20 Feb 2002 05:26:05 -0500
Received: from [195.63.194.11] ([195.63.194.11]:44550 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291719AbSBTKZu>; Wed, 20 Feb 2002 05:25:50 -0500
Message-ID: <3C737989.8040306@evision-ventures.com>
Date: Wed, 20 Feb 2002 11:25:13 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jakob Kemi <jakob.kemi@telia.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hex <-> int conversion routines.
In-Reply-To: <02021915240900.00635@jakob> <3C7274BE.1030803@evision-ventures.com> <02021919493204.00447@jakob>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>+static __inline__ char inthex_nibble(int x)
>>>+{
>>>+	const char* digits = "0123456789abcdef";
>>>+
>>>+	return digits[x & 0x0f];
>>>+}
>>>
>>perhaps better do static const char *digits.
>>
> GCC doesn't copy const strings, as opposed to other const arrays.
Currently.

> So it should be fine as it is. GCC also reuse duplicated strings.

