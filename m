Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbVLMJmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbVLMJmE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 04:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbVLMJmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 04:42:04 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:62654 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964897AbVLMJmC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 04:42:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=e8tDMK8nObfwBu7KPETkG+Zo16lmTrxQ3m/+TD9RWBcKQQV0AIJDnu0cr1tdD7n0UP0UPG3EnapfjsU2JMQVQJiYgVHrxGbHSePDd/YJwSWCAhC4tU1AISBezWuU9Mv4gnDW75TDKQhwfkCyCL+O/mVL8ttBLezq5y6uT0A68uY=
Message-ID: <439E9762.4070809@gmail.com>
Date: Tue, 13 Dec 2005 17:41:54 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: LKML List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Yet more display troubles with 2.6.15-rc5-mm2
References: <9a8748490512111306x3b01cb8cw2068a7ad3af93b03@mail.gmail.com>	 <439CBE49.2090901@gmail.com> <9a8748490512121031p11beaa51l7445ce1a5b31c3c6@mail.gmail.com>
In-Reply-To: <9a8748490512121031p11beaa51l7445ce1a5b31c3c6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On 12/12/05, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> Jesper Juhl wrote:
>>
> I'm already using the vesa driver. It seems to be the only Open Source
> driver that'll work with this card, so i don't have any other to try.
> 

I just tried with Xorg vesa and vgacon, and everything seems to work okay.
Now I'm not sure what changes in linux causes the vgacon state restore
to fail (VGA state restoration is almost the entire responsibility
of X, BTW), but maybe you can use vbetool to get and set the vga mode,
just to test?


Tony
