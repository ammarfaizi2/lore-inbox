Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290080AbSAQRfH>; Thu, 17 Jan 2002 12:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290081AbSAQRe5>; Thu, 17 Jan 2002 12:34:57 -0500
Received: from rhenium.btinternet.com ([194.73.73.93]:1532 "EHLO rhenium")
	by vger.kernel.org with ESMTP id <S290080AbSAQRer>;
	Thu, 17 Jan 2002 12:34:47 -0500
Content-Type: text/plain; charset=US-ASCII
From: Nick Sanders <sandersn@btinternet.com>
To: Joonas Koivunen <rzei@mbnet.fi>, linux-kernel@vger.kernel.org
Subject: Re: Power off NOT working, kernel 2.4.16
Date: Thu, 17 Jan 2002 17:30:45 +0000
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <3C45F45C.5000005@mbnet.fi>
In-Reply-To: <3C45F45C.5000005@mbnet.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16RGR3-0004Bk-00@rhenium>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> APM poweroff has actually been working with this computer, back when we
> used 2.0.36 type kernels, and that one was possibly redhat patched or
> something else, and windowses knew also how to poweroff, with mainboards
> drivers. APM poweroff seized to operate when I switched to 2.2 serie
> kernels.
>

I had the same problem the way I fixed it was added

apm power_off=1

to /etc/modules

this is using Debian (2.4.17 kernel)

Nick
