Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261790AbREPFZF>; Wed, 16 May 2001 01:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261791AbREPFYz>; Wed, 16 May 2001 01:24:55 -0400
Received: from cx595243-c.okc1.ok.home.com ([24.6.27.53]:42128 "EHLO
	quark.localdomain") by vger.kernel.org with ESMTP
	id <S261790AbREPFYn>; Wed, 16 May 2001 01:24:43 -0400
From: Vincent Stemen <linuxkernel@AdvancedResearch.org>
Date: Wed, 16 May 2001 00:25:08 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
Cc: hahn@coffee.psychology.mcmaster.ca
To: "Jacky Liu" <jq419@my-deja.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200105150713.AAA18791@mail7.bigmailbox.com>
In-Reply-To: <200105150713.AAA18791@mail7.bigmailbox.com>
Subject: Re: 2.4.4 kernel freeze for unknown reason
MIME-Version: 1.0
Message-Id: <01051600250800.24906@quark>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 May 2001 02:13, Jacky Liu wrote:
> Hi everyone,
>
> Mark, I got your point about the dma/udma stuffs. My hdparm setting is
> UDMA w/ MultiSector 16..
>
> I had recompiled my kernel and disabled the FB option but my linux box
> still hanged (another completely freeze) yesterday... Oh well..
>
> I have been tracking this thread for a few days and it seem the source of
> this problem is related to swap space. Vincent, would you mind to send me
> the patch for swap space problem if Alan had sent it to you? So I can
> test it on my machine and report the result later.
>

I havn't received the patch but, on Byron Stanoszek's suggestion, I
have compiled 2.4.4 with gcc-2.95.3 to run on it a few days to see if
it is any better.  So far, it appears at least as stable as with
egcs-1.1.2 and most of the swap was freed up this morning for the
first time since 2.4.0.  However, it is pretty full tonight.  I should
know tomorrow if it really made a difference.  This is usually the
state in which I find it locked up the next morning.  It has been up a
little over 2 days now.  Byron actually suggested I use the ac7 patch
but I first wanted to see if the compiler had anything to do with it
without changing anything else.

> Mark, please suggest a setting for the hdparm so I can test it on my
> machine. Thanks alot for your time.
>
> Best Regards,
> Jacky Liu
>
