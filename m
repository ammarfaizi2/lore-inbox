Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263538AbTDWUAL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 16:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbTDWUAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 16:00:10 -0400
Received: from mail.gmx.net ([213.165.65.60]:57544 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263538AbTDWUAJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 16:00:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrew Kirilenko <icedank@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Searching for string problems
Date: Wed, 23 Apr 2003 23:12:09 +0300
User-Agent: KMail/1.4.3
References: <200304231958.43235.icedank@gmx.net> <200304232248.35985.icedank@gmx.net> <Pine.LNX.4.53.0304231602270.26351@chaos>
In-Reply-To: <Pine.LNX.4.53.0304231602270.26351@chaos>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304232312.09987.icedank@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> >
> > And this code won't work as well :(
> >
> > Unfortunately, I can't start DOS and check, cause there is no video and
> > keyboard controller on that PC.
> >
>
> Change this:
>
>          movw    $0xe000, %ax
>
> To:
>          movw    $0xf000, %ax
>
> ... like I told you. The BIOS ROM contents, the stuff that has the
> serial number _must_ start where I told you.

Already solved the problem. AX was overwritten, before storing it's value (0 
or 1) into memory. The most stupid mistake, I've seen last year. 20 hours of 
kernel programming without breaks isn't really good.

Thanks too all of you, once again. You really saved my life.

Best regards,
Andrew.

