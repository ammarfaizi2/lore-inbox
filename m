Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264838AbTANR3u>; Tue, 14 Jan 2003 12:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264842AbTANR3t>; Tue, 14 Jan 2003 12:29:49 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:14022 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S264838AbTANR3s>; Tue, 14 Jan 2003 12:29:48 -0500
Message-ID: <3E244AB9.5010203@google.com>
Date: Tue, 14 Jan 2003 09:36:57 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ross Biro <rossb@google.com>
CC: Andre Hedrick <andre@linux-ide.org>, alan@lxorguk.ukuu.org.uk,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: PATCH: [2.4.21-pre3] IDE error recovery
References: <Pine.LNX.4.10.10301132318090.18906-100000@master.linux-ide.org> <3E2443FF.1030101@google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Biro wrote:

>
> One of the drives that has trouble claims ATA-2 through ATA-6, which 
> is interesting,  This means this device claims to support ATA-5, hence 
> we should be able to interpret the bits in the Identify device 
> according to ATA-5 which means it supports ATA-2 which it clearly does 
> not.   Only 1 of the 3 different drives I've looked at gets it right 
> and does not claim ATA-2 support when it does not support it.  I'll 
> drop an email to a couple of manufacturers and let them know their 
> drives have a problem.

I've just checked the latest drives from 4 different manufacturers.  3 
of them claim support for ATA-2 through ATA-6 and all of them have 
trouble with IDLEIMMEDIATE sent as part of the error recovery.  I've 
already sent an email to 2 of the vendors and I have a meeting already 
scheduled with the third tomorrow.

    Ross




