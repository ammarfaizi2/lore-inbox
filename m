Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266044AbRF1RTz>; Thu, 28 Jun 2001 13:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266043AbRF1RTf>; Thu, 28 Jun 2001 13:19:35 -0400
Received: from t2.redhat.com ([199.183.24.243]:12274 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S266039AbRF1RTc>; Thu, 28 Jun 2001 13:19:32 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.33.0106280956030.15199-100000@penguin.transmeta.com> 
In-Reply-To: <Pine.LNX.4.33.0106280956030.15199-100000@penguin.transmeta.com> 
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Patrick Dreker <patrick@dreker.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        jffs-dev@axis.com, linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Jun 2001 18:18:24 +0100
Message-ID: <6082.993748704@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



torvalds@transmeta.com said:
> Things like version strings etc sound useful, but the fact is that the
> only _real_ problem it has ever solved for anybody is when somebody
> thinks they install a new kernel, and forgets to run "lilo" or
> something.

I can give counter-examples of times when it's been extremely useful to 
know exactly what version the user is running, and the info messages
included in their first bug report have told me exactly what I needed to 
know.

> But even that information you really get from a simple "uname -a".

Only for code which is always distributed as part of the kernel, and where 
there are never any more up to date versions in the maintainer's tree, even 
temporarily.

Also consider the question "What was the last thing you see on screen 
before it reboots?"

--
dwmw2


