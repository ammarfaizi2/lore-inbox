Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVGUSPC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVGUSPC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 14:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVGUSPC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 14:15:02 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:51040 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261829AbVGUSPA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 14:15:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fSS1dcZwR9Ui95srWJB/2p5TBkI7ETjTyeRAJy6HJCiGIp2nIL7DZ/Qa2sfxPpybCwKKlhrOO27iCX4knt6xEHNyqUL+JB3PTL0iM7Sr5Yf5Vw3kyyq7Bx6alLQzYKux/LGHuHvOsLgqVJtMArCskpj7RGv+zZDspghzCwNPFEE=
Message-ID: <9a8748490507211114227720b0@mail.gmail.com>
Date: Thu, 21 Jul 2005 20:14:32 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Voluspa <lista1@telia.com>
Subject: Re: 2.6.13-rc3 Battery times at 100/250/1000 Hz = Zero difference
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050721200448.5c4a2ea0.lista1@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050721200448.5c4a2ea0.lista1@telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/05, Voluspa <lista1@telia.com> wrote:
> 
> I'd gladly (ehum..) redo this mind-numbingly boring test if someone can
> point me to a magic software which unleashes some untapped powersaving
> feature of the CPU.
> 
> _Kernel 2.6.13-rc3 Boot to Death_:
> 
> 2h48m at 100 HZ
> 2h48m at 250 HZ
> 2h47m at 1000 HZ
> 
> _"Load"_:
> 
> #!/bin/sh
> touch time-hz-start
> while (true) do
>     touch time-hz-end
>     sleep 1m
> done
> 
Ok, so with an idle machine, different HZ makes no noticeable
difference, but I'd suspect things would be different if the machine
was actually doing some work.
Would be more interresting to see how long it lasts with a light load
and with a heavy load.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
