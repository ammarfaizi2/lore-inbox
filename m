Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316679AbSGIRBL>; Tue, 9 Jul 2002 13:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316897AbSGIRBK>; Tue, 9 Jul 2002 13:01:10 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:15769 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316679AbSGIRBE> convert rfc822-to-8bit; Tue, 9 Jul 2002 13:01:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Thunder from the hill <thunder@ngforever.de>
Subject: Re: Driverfs updates
Date: Tue, 9 Jul 2002 19:05:28 +0200
User-Agent: KMail/1.4.1
Cc: Thunder from the hill <thunder@ngforever.de>,
       Keith Owens <kaos@ocs.com.au>, Patrick Mochel <mochel@osdl.org>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207090502510.10105-100000@hawkeye.luckynet.adm>
In-Reply-To: <Pine.LNX.4.44.0207090502510.10105-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207091905.28401.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 9. Juli 2002 13:08 schrieb Thunder from the hill:
> Hi,
>
> On Tue, 9 Jul 2002, Oliver Neukum wrote:
> > -It is slow.
>
> I wouldn't call it any fast when I think about the idea that 31 of my
> CPUs on Hawkeye shall be stopped because I unload a module. Sometimes at
> high noon my server (Hawkeye) can hardly keep up all the traffic. Just
> imagine a module would be unloaded then! That's the problem I'm having
> with it.
>
> What should make a lock for parts of the kernel slower than a lock for
> the _whole_ kernel?

Because you unload modules rarely, but you'd take the lock millions of times
in vain.

	Regards
		Oliver

