Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268015AbRGZPDa>; Thu, 26 Jul 2001 11:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268026AbRGZPDV>; Thu, 26 Jul 2001 11:03:21 -0400
Received: from chaos.analogic.com ([204.178.40.224]:44672 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268020AbRGZPDC>; Thu, 26 Jul 2001 11:03:02 -0400
Date: Thu, 26 Jul 2001 11:02:38 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: sentry21@cdslash.net
cc: linux-kernel@vger.kernel.org
Subject: Re: Weird ext2fs immortal directory bug
In-Reply-To: <Pine.LNX.4.30.0107261028000.18300-100000@spring.webconquest.com>
Message-ID: <Pine.LNX.3.95.1010726105812.16941A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 26 Jul 2001 sentry21@cdslash.net wrote:
[SNIPPED...]
> 
> Here's the problem(s) (or at least, the symptoms):
> 
> sentry21@Petra:1:/lost+found$ ls -l
> total 0
> lr----S---    1 52       12337           0 Nov  1  2022 #3147 ->
> 

Did you try..
# rm -r lost+found
# mklost+found

Without knowing how to use the ext2fs tools, and not wanting to
risk more damage, I tried this and it worked when I had such a
crash-induced problem.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


