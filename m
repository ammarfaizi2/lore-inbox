Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289379AbSA2KWZ>; Tue, 29 Jan 2002 05:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289466AbSA2KWP>; Tue, 29 Jan 2002 05:22:15 -0500
Received: from [195.66.192.167] ([195.66.192.167]:65294 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S289379AbSA2KWE>; Tue, 29 Jan 2002 05:22:04 -0500
Message-Id: <200201290940.g0T9etE27352@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
Subject: Re: [PATCH] KERN_INFO for devfs
Date: Tue, 29 Jan 2002 11:40:57 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000001c1a896$64e5ff40$21c9ca95@mow.siemens.ru>
In-Reply-To: <000001c1a896$64e5ff40$21c9ca95@mow.siemens.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 January 2002 05:27, Borsenkow Andrej wrote:
> > I changed "none" to "devfs" in do_mount("none", "/dev", "devfs", 0,
>
> ""):
> > "none is busy" is misleading at umount time :-)
>
> File systems that do not have real devices behind them have "none" as
> device. Please do not change it - it was correct. Having it later in
> /proc/mounts may confuse some user-level tools. If you want to fix it -
> fix umount to report something more sensible if device == none.

Why do you think they _have to_ have "none"? Is it POSIXized or otherwise 
standardized? Where can I RTFM?
--
vda
