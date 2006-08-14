Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751749AbWHNAAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbWHNAAY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 20:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751753AbWHNAAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 20:00:24 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:39746 "EHLO
	asav09.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1751749AbWHNAAW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 20:00:22 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AT0KACtZ30SBUQ
From: Dmitry Torokhov <dtor@insightbb.com>
To: Ben Buxton <kernel@bb.cactii.net>
Subject: Re: 2.6.18-rc4-mm1
Date: Sun, 13 Aug 2006 20:00:20 -0400
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Maciej Rutecki <maciej.rutecki@gmail.com>,
       linux-kernel@vger.kernel.org
References: <20060813012454.f1d52189.akpm@osdl.org> <20060813121126.b1dc22ee.akpm@osdl.org> <20060813224413.GA21959@cactii.net>
In-Reply-To: <20060813224413.GA21959@cactii.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608132000.21132.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 August 2006 18:44, Ben Buxton wrote:
> > Could be i8042-get-rid-of-polling-timer-v4.patch.  Please try the below
> > reversion patch, on top of rc4-mm1, thanks.
> 
> Acking the same issue. Applied the revert patch and my keyboard now
> works. Also, it turns out that my keyboard is now the only thing that
> failed to resume from S3 on my HP Nc6400, but adding "irqpoll" has fixed
> that for now.
> 

Can I please have dmesg of booting unpatched -rc4-mm1 with i8042.debug=1?

-- 
Dmitry
