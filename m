Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265058AbSK1BhH>; Wed, 27 Nov 2002 20:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265059AbSK1BhH>; Wed, 27 Nov 2002 20:37:07 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:31404 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S265058AbSK1BhG>; Wed, 27 Nov 2002 20:37:06 -0500
Date: Wed, 27 Nov 2002 17:48:33 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Module alias and table support
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Message-id: <3DE575F1.3000808@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200211280022.QAA07835@baldur.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > 	2.5.49 contains exports device ID tables again.

That's a start, but the 2.5 modutils don't handle them ...


>>Seems like one of the issues is that there's really no maintainer
>>for modutils lately.  And I'm not even sure where to get the latest
>>modutils (more recent than 0.7) even if I were ready to patch them.
> 
> 
> 	ftp://ftp.kernel.org/pub/linux/utils/kernel/modutils/v2.4/

Those won't work with the current 2.5 module syscalls though ...
the latest 2.5-usable modutils seems to be

ftp://ftp.kernel.org/pub/linux/kernel/people/rusty/module-init-tools-0.7.tar.bz2

but I've seen comments on LKML referring to a "0.8" version with
essential bugfixes.

- Dave


