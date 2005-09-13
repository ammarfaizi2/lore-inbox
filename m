Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbVIMLOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbVIMLOy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 07:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbVIMLOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 07:14:54 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:62168 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932334AbVIMLOx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 07:14:53 -0400
Message-ID: <4326B4E9.9060005@aitel.hist.no>
Date: Tue, 13 Sep 2005 13:15:53 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mathieu Fluhr <mfluhr@nero.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org> <1126608030.3455.23.camel@localhost.localdomain>
In-Reply-To: <1126608030.3455.23.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Fluhr wrote:

>On Mon, 2005-09-12 at 20:34 -0700, Linus Torvalds wrote:
>  
>
>>Ok, it's been two weeks (actually, two weeks and one day) since 2.6.13, 
>>and that means that the merge window is closed. I've released a 
>>2.6.14-rc1, and we're now all supposed to help just clean up and fix 
>>everything, and aim for a really solid 2.6.14 release.
>>
>>    
>>
>
>Sorry to bother you again and again with this stuff, but I got no answer
>from anyone... DVD burning is broken since 2.6.13-rc1 and I checked this
>morning the 2.6.14-rc1: Same status.
>
>To be short, when burning a DVD at 16x with 2.6.12.6, no problem at all.
>With 2.6.13-rc1 and upper, lots of buffer underruns. (If someone wants
>to help, feel free to ask more details... I would be happy to help
>anyone). The only thing that I know is that it is not coming from the
>peripheral driver, as I have the same issue when using ide-cd with a
>CDROM_SEND_PACKET ioctl or usb-storage+sg with a SG_IO ioctl.
>
>As far as I looked in the source code, it seems to be lots (and lots) of
>changes between these 2 versions, specially regarding block devices
>drivers. But the ChangeLog is so huge that it is quite impossible to
>make a step-by-step upgrade to see _where_ the problem is :-(
>  
>
You can do a bisection search with git, that will pinpoint exactly
which patch that cause trouble.  It is much easier to get a
maintainer to fix it if you can point the finger at one particular patch.

The recipe for bisection search is in the mailing list archives,
or send me an email, I've done it once.

Helge Hafting
