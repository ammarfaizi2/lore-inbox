Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbVHIJKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbVHIJKe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 05:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbVHIJKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 05:10:34 -0400
Received: from mail0.scram.de ([195.226.127.110]:35340 "EHLO mail0.scram.de")
	by vger.kernel.org with ESMTP id S932468AbVHIJKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 05:10:33 -0400
Message-ID: <42F872E3.3050106@scram.de>
Date: Tue, 09 Aug 2005 11:09:55 +0200
From: Jochen Friedrich <jochen@scram.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: Lee Revell <rlrevell@joe-job.com>, abonilla@linuxwireless.org,
       "'Andreas Steinmetz'" <ast@domdv.de>,
       "'Arjan van de Ven'" <arjan@infradead.org>,
       "'Denis Vlasenko'" <vda@ilport.com.ua>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: Wireless support
References: <005501c59c4a$f6210800$a20cc60a@amer.sykes.com> <1123528018.15269.44.camel@mindpipe> <20050808232957.GR4006@stusta.de>
In-Reply-To: <20050808232957.GR4006@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>I see at least two disadvantages:
>
>First, it doesn't encourage hardware manufacturers to support open 
>source development.
>
>Linux has only a small market share, but it's slowly growing.
>
>Linux driver support does sometimes influence the decision which 
>hardware to buy.
>
>With NdisWrapper, the hardware manufacturer can say:
>  "Our hardware is supported through the open source NdisWrapper."
>
>Without NdisWrapper, they will sometimes hear that people did choose to 
>buy hardware from a different hardware manufacturer that has a Linux 
>driver. This can make the hardware manufacturer more friendly towards 
>open source development (e.g. by providing hardware specs).
>
>Secondly, binary-only drivers have an impact on the stability of the 
>Linux kernel.
>
>E.g. during the last years the nvidia has produced relatively many 
>kernel crashes - and I doubt that binary-only drivers for Windows are 
>much better in this respect.
>
>The users only see their kernel crashing blaming the Linux kernel and 
>harming the reputation of the stability of Linux.
>  
>

Third, both ndiswrapper and binary-only drivers only work on one platform.

E.g. broadcom has a binary-only driver for their WLAN card on Linux, but
only for mipsel (wrt54g).

On Alpha or PowerPC, most WLAN equipment doesn't work under Linux, at all.

Jochen
