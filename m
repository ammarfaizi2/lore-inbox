Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317620AbSFSHpc>; Wed, 19 Jun 2002 03:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317806AbSFSHpb>; Wed, 19 Jun 2002 03:45:31 -0400
Received: from [195.63.194.11] ([195.63.194.11]:59404 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317620AbSFSHpb> convert rfc822-to-8bit; Wed, 19 Jun 2002 03:45:31 -0400
Message-ID: <3D103697.9000109@evision-ventures.com>
Date: Wed, 19 Jun 2002 09:45:27 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: leif@denali.net
CC: linux-kernel@vger.kernel.org, arnd@bergmann-dalldorf.de
Subject: Re: 2.5.22 ide disk hang on boot
References: <20020619061243.2698F3C8B4@hedwig.denali.net>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik leif@denali.net napisa³:
> I'm having exactly the same issue, with both 2.5.22 and 2.5.23.
> 
> I've downloaded the ide-clean-92.diff and applied it against 2.5.23.  There were some fuzzy offsets, but no rejects.
>
You mean you have reverse applied it with the patch -R command of course.
Yes 92 is the culprit. I have put it in the change log that
the unification of the PIO read handlers is dangerous and well indeed it is...

