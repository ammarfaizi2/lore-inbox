Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129423AbRBLQaG>; Mon, 12 Feb 2001 11:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129907AbRBLQ35>; Mon, 12 Feb 2001 11:29:57 -0500
Received: from [212.250.174.135] ([212.250.174.135]:37034 "EHLO 5emedia.net")
	by vger.kernel.org with ESMTP id <S129423AbRBLQ3m>;
	Mon, 12 Feb 2001 11:29:42 -0500
User-Agent: Microsoft-Outlook-Express-Macintosh-Edition/5.02.2022
Date: Mon, 12 Feb 2001 16:29:40 +0000
Subject: Re: "Unable to load intepreter" on login - 2.2.14-5.0
From: Paul Tweedy <pault@5emedia.net>
To: <linux-kernel@vger.kernel.org>
Message-ID: <B6ADBFF3.3E19%pault@5emedia.net>
In-Reply-To: <E14SL30-0007J5-00@the-village.bc.nu>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on 12/2/01 15:37,  Alan Cox <alan@lxorguk.ukuu.org.uk> schribe:

> rpm --verify --all
> 
> That will check all the packages seem sane. It won't neccessarily help
> identify the problem but can reassure you as what if anything may be corrupt.
> 
> If it shows up changes in login, netstat, su and the like then assume the
> worst.
> If it shows permission changes on the library then you have a good idea what
> may have happened.

Thanks Alan - spot on. I ran this and there's been a permissions change to
/bin/login a couple of days ago. I smell a hacker... ?

Firstly - GRRRRRRRRRRRR.

Secondly, to get the thing running I'm assuming I can copy a working login
binary from an identical server, so I can get in & change the passwords and
sort the security out?

I'm thinking it's not a coincidence that my system logs disappeared either..
:(

/paul

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
