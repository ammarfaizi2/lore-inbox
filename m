Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264853AbSKELSc>; Tue, 5 Nov 2002 06:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264854AbSKELSc>; Tue, 5 Nov 2002 06:18:32 -0500
Received: from mailgw3a.lmco.com ([192.35.35.7]:59154 "EHLO mailgw3a.lmco.com")
	by vger.kernel.org with ESMTP id <S264853AbSKELSb>;
	Tue, 5 Nov 2002 06:18:31 -0500
Content-return: allowed
Date: Tue, 05 Nov 2002 06:24:58 -0500
From: "Reed, Timothy A" <timothy.a.reed@lmco.com>
Subject: RE: idle=poll needed??
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "Reed, Timothy A" <timothy.a.reed@lmco.com>
Cc: "Linux Kernel ML (E-mail)" <linux-kernel@vger.kernel.org>
Message-id: <9EFD49E2FB59D411AABA0008C7E675C00DCDFC53@emss04m10.ems.lmco.com>
MIME-version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are not concerned with power use.

What it is we are running is a math intensive program.  When the sub uses
the idle flag and run their test they get a run time of 370ms, when they do
not use the flag they get a run time of 255ms.  Yes I know that 115ms is not
much of a difference, but in our application it could be.  I have asked them
to send me a copy of their sim so that I may attempt to reproduce it here
and reevaluate our kernel build options.

We need to do much more testing.  My opinion is that we won't be able to
decide until we get all of the pieces into system integration.

Thanks,
Timothy Reed
Software Engineer \ Systems Administrator
Lockheed Martin - NE & SS Syracuse
Email: timothy.a.reed@lmco.com

The Box Said "Requires Windows  95 or Better", so I installed Linux!


-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Monday, November 04, 2002 8:43 AM
To: Reed, Timothy A
Cc: Linux Kernel ML (E-mail)
Subject: Re: idle=poll needed??


On Mon, 2002-11-04 at 12:51, Reed, Timothy A wrote:
> All,
> 	We currently have setup, Dual P4-Xeon 2.2G machines running 2.4.19,
> with 2GB of RAM.
> 	Is there any performance reasons to keep the idle=poll in the append
> line?  I have not seen any degraded performance with the option, but some
of
> our subs are having performance issues with it in.

It actually depends on what you are doing whether it has any impact.
Also of course if power use is a consideration
