Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbVJQKB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbVJQKB6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 06:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbVJQKB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 06:01:58 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:24966 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S932244AbVJQKB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 06:01:57 -0400
Message-ID: <43537666.9030007@gmail.com>
Date: Mon, 17 Oct 2005 12:01:10 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: linux-kernel@vger.kernel.org, Jiri Slaby <xslaby@fi.muni.cz>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCHv3 6/6] char, isicom: More whitespaces and coding style
References: <20051016222734.375FD22B371@anxur.fi.muni.cz> <200510170117.21429.dtor_core@ameritech.net>
In-Reply-To: <200510170117.21429.dtor_core@ameritech.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov napsal(a):
> On Sunday 16 October 2005 17:27, Jiri Slaby wrote:
> 
> 
>>+					wrd |= (port->xmit_buf[port->xmit_tail]
>>+									<< 8);
> 
> 
>>+						pr_dbg("interrupt: DCD->low.\n"
>>+							);
> 
> 
>>+		port->xmit_head = (port->xmit_head + cnt) & (SERIAL_XMIT_SIZE
>>+			- 1);
> 
> 
> You must be kidding...
No :(. The last could be better, but that two, I don't know, how to write
better. What do you think? [Consider, it won't be applied with more than 80
columns, IMHO]

regards,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
