Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbWEUSz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWEUSz3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 14:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWEUSz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 14:55:29 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:24185 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964909AbWEUSz2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 14:55:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bjXJdwxE7mmu1CQTnZfKY4onMK75G6WGUPySDOaFvzhZYrPg1rUcCCEcM+Kz+vl2oLC9tZB7TxJxsubJPZitUEdpM1btDirQefiwQyjHr2oJOR6WlPgee6FGPHtnzgdkh6bzeOhSzUezgjBOXf1EsqZphoYNuIhQCMYktgyt6DU=
Message-ID: <7c3341450605211155i3674a27bob6213b449e2d1a3a@mail.gmail.com>
Date: Sun, 21 May 2006 19:55:28 +0100
From: "Nick Warne" <nick.warne@gmail.com>
Reply-To: nick@linicks.net
To: Antonio <tritemio@gmail.com>
Subject: Re: : unclean backward scrolling
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5486cca80605210638l2906112fv515df1bc390cff24@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5486cca80605210638l2906112fv515df1bc390cff24@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmmph.

I get this problem, and always have, but I always put it down to my system.

I run Slackware 10, and this has always happened to me from 2.6.2
upwards on CRT 1024x768 and later TFT 1280x1024 dvi.

I use[d] in lilo:

# VESA framebuffer console @ 1280x1024x?k
vga=794
# VESA framebuffer console @ 1024x768x64k
#vga=791

So you are not alone.

Nick

On 21/05/06, Antonio <tritemio@gmail.com> wrote:
> Hi,
>
> I'm using the radeonfb driver with a radeon 7000 with the frambuffer
> at 1280x1024 on a i386 system, with a 2.6.16.17 kernel. At boot time,
> if I stop the messages with CTRL+s and try look the previous messages
> with CTRL+PagUp (backward scrolling) the screen become unreadable. In
> fact some lengthier lines are not erased scrolling backward and some
> random characters a overwritten instead. So it's very difficult to
> read the messages.
>
> I don't have such problem with the frambuffer at 1024x768.
>
> All the previous kernels I've tried have this problem (at least up to
> 2.6.15).
>
> If someone can look at this issue I can provide further information.
>
> Many Thanks.
>
> Cheers,
>
>   ~ Antonio
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
