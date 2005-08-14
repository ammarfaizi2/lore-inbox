Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbVHNX3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbVHNX3k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 19:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbVHNX3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 19:29:39 -0400
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:675 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932352AbVHNX3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 19:29:39 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: usb camera failing in 2.6.13-rc6
Date: Mon, 15 Aug 2005 09:29:20 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <mailman.1124005092.8274.linux-kernel2news@redhat.com> <200508141842.13209.kernel@kolivas.org> <20050814115648.4f12f1ec.zaitcev@redhat.com>
In-Reply-To: <20050814115648.4f12f1ec.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508150929.21402.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2005 04:56, Pete Zaitcev wrote:
> On Sun, 14 Aug 2005 18:42:12 +1000, Con Kolivas <kernel@kolivas.org> wrote:
> > On Sun, 14 Aug 2005 18:00, Pete Zaitcev wrote:
> > > On Sun, 14 Aug 2005 17:12:06 +1000, Con Kolivas <kernel@kolivas.org>
> > > wrote:
> >
> > Yes all those dmesgs etc were redone after it failed in rc6 as I needed
> > it working. Oh and all other usb devices - mouse, printer, scanner,
> > keyboard are working fine in rc6; it's just the camera.
>
> This should be diffable. You caught this regression relatively early.
> But I'm afraid you have to go through the divide-by-half excercise.
>
> If I were a betting man, I'd bet on this:

> Remember that dmesg diff you sent? That's the one. If you strace
> the digikamcameracl, it probably keels over after EBUSY.

Nice shot! Got it in one. bugzilla updated with confirmation.

So how do we proceed with this one? Do I need to file a digikam bug report 
too?


Cheers,
Con
