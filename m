Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbUL1Qtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbUL1Qtq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 11:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbUL1Qtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 11:49:46 -0500
Received: from rekin10.go2.pl ([193.17.41.30]:3492 "EHLO r10.go2.pl")
	by vger.kernel.org with ESMTP id S261189AbUL1Qtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 11:49:40 -0500
From: =?iso-8859-2?Q?Fryderyk_Mazurek?= <dedyk@go2.pl>
To: =?iso-8859-2?Q?Alan_Cox?= <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: =?iso-8859-2?Q?Re:_Problems_with_2.6.10?=
Date: Tue, 28 Dec 2004 17:49:39 +0100
Content-Type: text/plain; charset="iso-8859-2";
Content-Transfer-Encoding: 8bit
X-Mailer: o2.pl WebMail v5.27
X-Originator: 83.31.161.254
In-Reply-To: <1104238047.20952.74.camel@localhost.localdomain>
References: <20041227171159.51454193BFA@r10.go2.pl> 
	<1104238047.20952.74.camel@localhost.localdomain>
Message-Id: <20041228164939.79157193D1F@r10.go2.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for reply. My disk doesn't stop, when I do "reboot". I
hear as works (of course silently). Also when I turn off computer I
hear when spins the drive down. And one thing. I also saw that when
BIOS had detected disk (after 2.6.10) then light's disk went out.

Fryderyk.

PS. I want to say that my English is not good and maybe I did error.
If I did it, please forgive me.

---- Wiadomo¶æ Oryginalna ----
Od: Alan Cox <alan@lxorguk.ukuu.org.uk>
Do: Fryderyk Mazurek <dedyk@go2.pl>
Kopia do: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Data: Tue, 28 Dec 2004 14:27:53 +0000
Temat: Re: Problems with 2.6.10

> On Llu, 2004-12-27 at 17:11, Fryderyk Mazurek wrote:
> > Hi everyone!
> > 
> > I have so strange problem with kernel 2.6.10. Kernel works good, but
> > problem starts when I do reboot. On boot screen my bios can't detect
> > my disk. Bios stops and nothing. So without end. Button reset on my
> > towel can't fix it. To fix this situation I must turn off and turn
> > on my computer. Only it helps. With kernel 2.6.9 wasn't so problem.
> > How to fix it?
> 
> The IDE code is meant to spin the drive down on poweroff but not on
> "reboot". If the new power changes upset this then a few boxes will do
> as you describe because the BIOS isn't bright enough to get the drive
> powered back up.
> 
> Alan
> 
> 
