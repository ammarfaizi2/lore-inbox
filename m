Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267758AbRGZQxk>; Thu, 26 Jul 2001 12:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268335AbRGZQxb>; Thu, 26 Jul 2001 12:53:31 -0400
Received: from chaos.analogic.com ([204.178.40.224]:52096 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267758AbRGZQxS>; Thu, 26 Jul 2001 12:53:18 -0400
Date: Thu, 26 Jul 2001 12:52:48 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Wayne.Brown@altec.com
cc: sentry21@cdslash.net, linux-kernel@vger.kernel.org
Subject: Re: Weird ext2fs immortal directory bug
In-Reply-To: <86256A95.00581EDA.00@smtpnotes.altec.com>
Message-ID: <Pine.LNX.3.95.1010726124930.18506A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 26 Jul 2001 Wayne.Brown@altec.com wrote:

> 
> 
> Try lsattr ./#3147 and see if the i attribute is set.  If so, then
> (as root) do
> chattr -i ./#3147 and try again to remove it.
> 
> Wayne

If you try that from a shell, it may fail because '#' means
"ignore everything thereafter", so you are trying to do muck
with the directory. I think:

chattr -i ./\#3147 had ought to do it.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


