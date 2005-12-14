Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030322AbVLNBWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322AbVLNBWk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 20:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030332AbVLNBWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 20:22:40 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:42961 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030322AbVLNBWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 20:22:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Yyh4GOFRSG9KAtWg+xVd8JL7mVQpZYaV3VnlEo9tldO67luvR4r3olCUuBxlPTKMnGVNk5xkD6OGXN3oSPzmla+LmfEM0HCwLY6lfMv/N9CQVV4QTfRqzNk8q5dA7+lD+Quqyb8GiCnf4B3ScH9nJUi4LhaWi2yF56RGuH6NLW8=
Message-ID: <439F73D4.9060304@gmail.com>
Date: Wed, 14 Dec 2005 09:22:28 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: LKML List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Yet more display troubles with 2.6.15-rc5-mm2
References: <9a8748490512111306x3b01cb8cw2068a7ad3af93b03@mail.gmail.com>	 <439CBE49.2090901@gmail.com>	 <9a8748490512121031p11beaa51l7445ce1a5b31c3c6@mail.gmail.com>	 <439E9762.4070809@gmail.com> <9a8748490512131319o408a368eqfed225abebaff4d@mail.gmail.com>
In-Reply-To: <9a8748490512131319o408a368eqfed225abebaff4d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On 12/13/05, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> Jesper Juhl wrote:
>>> On 12/12/05, Antonino A. Daplas <adaplas@gmail.com> wrote:
>>>> Jesper Juhl wrote:
>>>>
>>> I'm already using the vesa driver. It seems to be the only Open Source
>>> driver that'll work with this card, so i don't have any other to try.
>>>
>> I just tried with Xorg vesa and vgacon, and everything seems to work okay.
>> Now I'm not sure what changes in linux causes the vgacon state restore
>> to fail (VGA state restoration is almost the entire responsibility
>> of X, BTW), but maybe you can use vbetool to get and set the vga mode,
>> just to test?
>>
> Ok, I'm not familiar with that tool and my distribution doesn't
> include it, but if it will be useful to you for me to test with  it
> I'll get and install it. What exactely would you like me to do/try
> with it?

The vbetool is capable of getting/setting or saving/restoring the current
state of the hardware.  You can run vbetool vbestate save before going
to X and then run vbetool vbestate restore after switching back to console.

Tony 
