Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292669AbSBURk0>; Thu, 21 Feb 2002 12:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292672AbSBURkV>; Thu, 21 Feb 2002 12:40:21 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:15364 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S292669AbSBURkH>; Thu, 21 Feb 2002 12:40:07 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: linux kernel config converter
Date: 21 Feb 2002 15:22:08 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrna7a450.amh.kraxel@bytesex.org>
In-Reply-To: <E16duzn-0007E0-00@the-village.bc.nu> <3C750D8A.435317E4@mandrakesoft.com>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1014304928 10962 127.0.0.1 (21 Feb 2002 15:22:08 GMT)
User-Agent: slrn/0.9.7.1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
>  Alan Cox wrote:
> > You can do that with CML1 or his code. The problem is that you need to
> > go back through checking with the user because
>  
>  I think I am stumbling over semantics... I know you can turn on needed
>  stuff when you say "I want CONFIG_USB_HID",
>  but "I want this feature, turn on everything I need" sounded to me more
>  like autoconfigurator-type stuff, which is guessing at best.

To stick with that example:  CML1 knows (and tools could use that) that
CONFIG_USB_HID needs CONFIG_INPUT.  But CML1 doesn't know that you also
need at a host controller driver (CONFIG_USB_UHCI for example).  And
even if the config tool would know, it still wouldn't be able to pick
the correct one ...

  Gerd

-- 
#define	ENOCLUE 125 /* userland programmer induced race condition */
