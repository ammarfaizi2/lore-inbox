Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbVLUTAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbVLUTAp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 14:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbVLUTAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 14:00:45 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:30125 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751160AbVLUTAo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 14:00:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=om+ioDbA7WKKWM92RiwRaRade6NpyG300ObOryLJiz31xbN082zAsh9YE4jyGJSkClLEYfWsV3ERWVmeMXQaa1KjUreGUk4Oj9zvzZk6k2X7qrbohy1quUTjZwQESNndXPMdSU5FhA+O9HCKiTh4DB5YB/MICeN/DdttTP8OIUU=
Message-ID: <9a8748490512211100m1d360d7et437ad7da9699ff1d@mail.gmail.com>
Date: Wed, 21 Dec 2005 20:00:43 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: Question on the current behaviour of malloc () on Linux
Cc: Jie Zhang <jzhang918@gmail.com>,
       Linux kernel <linux-kernel@vger.kernel.org>, lars.friedrich@wago.com
In-Reply-To: <Pine.LNX.4.61.0512211259090.12113@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6f48278f0512210936y25169c37t9fb7eb13fef3a97d@mail.gmail.com>
	 <Pine.LNX.4.61.0512211259090.12113@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/05, linux-os (Dick Johnson) <linux-os@analogic.com> wrote:
[snip]
>
> To make your wishes come true execute:
>      echo "1" >/proc/sys/vm/overcommit_memory

s/"1"/"2"/

> ... as a super-user.
>
> That will make malloc() fail when there isn't any more virtual
> memory.
>
[snip]

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
