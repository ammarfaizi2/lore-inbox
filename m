Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129826AbRA2Lbb>; Mon, 29 Jan 2001 06:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130330AbRA2LbL>; Mon, 29 Jan 2001 06:31:11 -0500
Received: from mail09.voicenet.com ([207.103.0.35]:1183 "HELO
	mail09.voicenet.com") by vger.kernel.org with SMTP
	id <S129826AbRA2LbC>; Mon, 29 Jan 2001 06:31:02 -0500
Message-ID: <3A75546F.DAC87368@voicenet.com>
Date: Mon, 29 Jan 2001 06:30:55 -0500
From: safemode <safemode@voicenet.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adrian Cox <apc@agelectronics.co.uk>
CC: Dylan Griffiths <Dylan_G@bigfoot.com>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: More on the VIA KT133 chipset misbehaving in Linux
In-Reply-To: <3A75278F.B41B492B@bigfoot.com> <3A75507A.9386AFE2@agelectronics.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Cox wrote:

> Dylan Griffiths wrote:
> > The VIA KT133 chipset exhibits the following bugs under Linux 2.2.17 and
> > 2.4.0:
> > 1) PS/2 mouse cursor randomly jumps to upper right hand corner of screen and
> > locks for a bit
>
> This happens to me about once a month on a BX chipset PII machine here,
> and on a KT133 chipset machine I have.  I have to hit ctrl-alt-backspace
> to regain control of the console. I always assumed it was a bug in X,
> but it never caused me enough trouble to actually make me pursue it.
>
> - Adrian
>

turn off gpm..   fixes the mouse problem immediately.   as in killall -9 gpm
before starting X.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
