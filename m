Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWAAOVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWAAOVY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 09:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWAAOVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 09:21:24 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:22858 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932211AbWAAOVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 09:21:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ZDeAI2G8rVYcnQrG9yC/f3X1TVwZIYP8uBfHHSk4nfDWuhfZQRbV6Qym8snpKpCJv7xBSOHfRYYzY3i2XcG+arUSSJsvdWxlaMwICJ6FnLFhgvrQ00hvDUqQLGHETsIN4fYyoCTNHv7sMx6Zz6x4NCT52dNSDohwusp5IfeujU4=
Message-ID: <43B7E576.6000004@gmail.com>
Date: Sun, 01 Jan 2006 19:21:42 +0500
From: "Alexander E. Patrakov" <patrakov@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: MPlayer broken under 2.6.15-rc7-rt1?
References: <20051231202933.4f48acab@galactus.example.org>	 <1136106861.17830.6.camel@laptopd505.fenrus.org>	 <20060101115121.034e6bb7@galactus.example.org> <1136114772.17830.20.camel@laptopd505.fenrus.org>
In-Reply-To: <1136114772.17830.20.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

> What you have here is a bit of a gray area; you're using one of the
> maybe-illegal binary modules that has a really long history of
> introducing bugs that, just from the oops, may appear unrelated to this
> module, and you can't reproduce it without. Just not because the bug
> won't happen, but because you state that the application that triggers
> it won't run without it.

Wrong. The "nv" driver supports xvideo, and does this better than the 
official "nvidia" driver. When I had a GeForce 2 MX 200 (now this card 
is dead), my computer was was fast enough to play DVDs with 
deinterlacing with the "nv" driver, but not with "nvidia". Probably due 
to improper MTRR setup done by the "nvidia" driver.

So the original reporter was actually just lazy or misinformed about the 
capabilities of the "nv" driver.

-- 
Alexander E. Patrakov
Don't mail to patrakov@ums.usu.ru: the server is off until 2006-01-11
Use my GMail or linuxfromscratch address instead
