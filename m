Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310370AbSCLCyl>; Mon, 11 Mar 2002 21:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310367AbSCLCyV>; Mon, 11 Mar 2002 21:54:21 -0500
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:59369 "EHLO
	avocet.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S310363AbSCLCyS>; Mon, 11 Mar 2002 21:54:18 -0500
Message-ID: <01a901c1c971$307d25c0$1125a8c0@wednesday>
From: "J. Dow" <jdow@earthlink.net>
To: "Linus Torvalds" <torvalds@transmeta.com>,
        "Jeff Garzik" <jgarzik@mandrakesoft.com>
Cc: <andersen@codepoet.org>, "Bill Davidsen" <davidsen@tmr.com>,
        "LKML" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0203111810220.8121-100000@home.transmeta.com>
Subject: Re: [patch] My AMD IDE driver, v2.7
Date: Mon, 11 Mar 2002 18:54:12 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Linus Torvalds" <torvalds@transmeta.com>

> Yeah yeah. You can add additional levels of protection, and we have
> capabilities.
> 
> Add a special password-protected capability, so that only YOU can enable
> certain hardware access stuff. Where does it end? Is one such capability
> enough? How do you initialize the default values for the system if you
> need to be there to type in the password at bootup every time? We're
> talking about some rather fundamental things here, and these are issues
> that go _far_ beyond some silly ATA stack layer.

Linus, this discussion hung on long enough I decided to start reading it.
So I may have missed something. However, I notice you speak of a networking
example. I believe it is a strawman. The real comparison is closer to that
between IDE and SCSI. Do the SCSI device drivers filter? What and how do
they filter if they do at all? Aren't they a better model to adopt for
a system consistent interface philosophy?

{^_^}   Joanne Dow, jdow@earthlink.net


