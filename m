Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264789AbSJOU4Z>; Tue, 15 Oct 2002 16:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264818AbSJOU4Z>; Tue, 15 Oct 2002 16:56:25 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:27894 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S264789AbSJOU4X>; Tue, 15 Oct 2002 16:56:23 -0400
Date: Tue, 15 Oct 2002 14:00:42 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] 2.5.42-ac1, 2.5.42,
 2.5.41 boot hang with CONFIG_USB_DEBUG=n
To: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
Cc: greg@kroah.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-id: <3DAC81FA.60305@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <20021013172557.GA890@rousalka.noos.fr>
 <3DAAF67F.1080504@pacbell.net> <20021014212000.GA1002@rousalka.noos.fr>
 <3DAC4BE8.6080109@pacbell.net> <20021015173928.GA972@rousalka.noos.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Mailhot wrote:
>> Well, I've seen USB getting annoyingly flakey results in recent kernels.
>> ...
> 
> Well, I knew AMD 756 + USB was a bit risky, guess I was too much in a 
> 2.5 mood when I bought this keyboard.

I wouldn't call that combo risky, not since AMD told us the
workaround.  There might be a few minor teething problems in
the 2.5 stack, once this recent flakiness gets resolved, but
it ought to work just fine.


>> There are some one-liners floating around that make it a lot better,
>> like making drivers/base/core.c found_match() "return error != 0"
>> (true == matched) instead of "return error" (true == failed).  That

Sorry, make that "return error == 0".

- Dave



