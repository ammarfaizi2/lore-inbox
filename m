Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265580AbTGIApd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 20:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267995AbTGIApd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 20:45:33 -0400
Received: from mithril.c-zone.net ([63.172.74.235]:56078 "EHLO mail.c-zone.net")
	by vger.kernel.org with ESMTP id S265580AbTGIAp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 20:45:28 -0400
Message-ID: <3F0B6930.3080009@c-zone.net>
Date: Tue, 08 Jul 2003 18:00:32 -0700
From: jiho@c-zone.net
Organization: Kidding of Course
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: =?ISO-8859-1?Q?C=E9dric?= Barboiron <ced2ml@ifrance.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: hdX lost interrupt problem
References: <3F0AE4DF.80808@ifrance.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Cédric Barboiron wrote:

> Hello,
> 
> I'm currently having troubles while trying to listen or rip cds audios.
> `cdparanoia -Q` works fine
> but `strace cdparanoia 1` hangs at :
> ioctl(3, 0x530e
> 
> Then I have from `dmesg` :
> hdc: lost interrupt
> hdc: lost interrupt
> (...)
> hdc: lost interrupt
> hdc: lost interrupt


[ ... ]


> Some infos from /proc/ide/ide1/hdc :
> driver: ide-cdrom version 4.59-ac1
> model: CRD-8322B


Sorry, my brain must have been overheating, I missed this in my other 
reply to your post, when I asked what drive.

Don't know if case cooling would have any bearing on this or not, but I 
think I'll run some tests of my own.  I seem to recall one incident 
while I was unrolling a tarball off a CD onto a hard drive, that 
happened to involve a VIA chipset.  I'll see if I can reproduce the 
incident.


-- Jim Howard  <jiho@c-zone.net>

