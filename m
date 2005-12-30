Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbVL3BTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbVL3BTR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 20:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbVL3BTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 20:19:17 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:20396 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751191AbVL3BTQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 20:19:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eisFur/Nadc2Nb1XByS41vPIZQ4+mQugwDWAmHZLqCXjf1TUzzULnZ8DaWi7m2lT7rydh7M88cWLRGD9s0TZhV2WEePOJAbGtfRkFBW3+THwPNsVMqFhZySliPn4LONs+uerTkGy/rX09od3Pkt66Ft8c9lqtGL9gNQaVVZc4iU=
Message-ID: <21d7e9970512291719o331fb026t11c7bc596798da40@mail.gmail.com>
Date: Fri, 30 Dec 2005 12:19:14 +1100
From: Dave Airlie <airlied@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: userspace breakage
Cc: Dave Jones <davej@redhat.com>, Ryan Anderson <ryan@michonline.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0512291702140.3298@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
	 <20051228201150.b6cfca14.akpm@osdl.org>
	 <20051229073259.GA20177@elte.hu>
	 <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org>
	 <20051229202852.GE12056@redhat.com>
	 <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org>
	 <20051229224103.GF12056@redhat.com> <43B48176.3080509@michonline.com>
	 <20051230004608.GA12822@redhat.com>
	 <Pine.LNX.4.64.0512291702140.3298@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Can you actually detail this thing a bit more? I'm a FC4 user myself, and
> I'm sure as hell running X too. And that's not even a special X install
> like I used to have, it's bog-standard FC4 afaik.
>
> And I'm definitely running -rc7 (well, not exactly, it's my current git
> tree, so it's -rc7+patches).

/dev/input/event* disappear, I've just noticed this myself yesterday
working on Xegl, I thought I'd done something wrong, then I realised
udev/kernel issues and I just created them by hand..

Your X might not be using evdev....

Dave.
