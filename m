Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268973AbRHBQAu>; Thu, 2 Aug 2001 12:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268988AbRHBQAa>; Thu, 2 Aug 2001 12:00:30 -0400
Received: from chaos.analogic.com ([204.178.40.224]:896 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268973AbRHBQAT>; Thu, 2 Aug 2001 12:00:19 -0400
Date: Thu, 2 Aug 2001 11:59:17 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andries.Brouwer@cwi.nl
cc: alan@lxorguk.ukuu.org.uk, davem@redhat.com, mbartz@optushome.com.au,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: setsockopt(..,SO_RCVBUF,..) sets wrong value
In-Reply-To: <200108021438.OAA110364@vlet.cwi.nl>
Message-ID: <Pine.LNX.3.95.1010802115141.262A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2001 Andries.Brouwer@cwi.nl wrote:

[SNIPPED...]
Then shouldn't it return exactly the value that was set?

Whatever the kernel does internally with the value is of no
concern to the caller at the API. It could multiply it by the
phase-of-the-moon if necessary.

When an API says "set_foo(123)", it must be able to do
"val = get_foo()" and retrieve the same value. If not, it's
broken.

Instead of writing more documentation to explain an obvious bug
at the API, it should simply be fixed.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


