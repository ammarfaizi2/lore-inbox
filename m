Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWBZXiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWBZXiz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 18:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWBZXiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 18:38:55 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:1839 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750871AbWBZXiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 18:38:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=pkSzFnaNLysdtOBHbRm37yDjqnhkZSTaI96au1FBLmyOdEQgQVcAwSIYq4ir2kXCDEpsdzITeQ97USVgEeoZTFiIb8dfzi0TH3QzJbrB4qX4xgCTZ9LHVezWyI4bt9sb36w5XU+aY56E2d2oDaE1S4xlTPUnOUJCLOTd/K7DFCM=
Message-ID: <44023BF3.7060703@gmail.com>
Date: Mon, 27 Feb 2006 07:38:27 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       info-linux@geode.amd.com
Subject: Re: 2.6.16-rc4-mm2
References: <20060224031002.0f7ff92a.akpm@osdl.org>	 <9a8748490602250359w7880d820lae65ceb50bf6e08e@mail.gmail.com>	 <20060225041703.6d771f10.akpm@osdl.org>	 <9a8748490602250425m6d99cd54la451795648c31c42@mail.gmail.com>	 <20060225043102.73d1a7d8.akpm@osdl.org> <9a8748490602250441h710fd194u420ffbac58d7a18d@mail.gmail.com>
In-Reply-To: <9a8748490602250441h710fd194u420ffbac58d7a18d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On 2/25/06, Andrew Morton <akpm@osdl.org> wrote:
>> "Jesper Juhl" <jesper.juhl@gmail.com> wrote:
>>> On 2/25/06, Andrew Morton <akpm@osdl.org> wrote:
>>>  > "Jesper Juhl" <jesper.juhl@gmail.com> wrote:
>>>  > >
>>>  > >  On 2/24/06, Andrew Morton <akpm@osdl.org> wrote:
>>>  > >  >
>> CONFIG_FB=m, CONFIG_FB_GEODE_GX=y.   An easy mistake, that.
>>

Need to change CONFIG_FB_GEODE_GX to depends on (FB = y)

> 
> Does it even make sense to build CONFIG_FB modular?
> 

If you're a developer.

Tony

