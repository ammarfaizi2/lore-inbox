Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262602AbVAKBO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbVAKBO6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 20:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbVAKBOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 20:14:47 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:49548 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262741AbVAKBJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 20:09:22 -0500
Subject: Re: Screwy clock after apm suspend
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Bernard Blackham <bernard@blackham.com.au>, Shaw <shawv@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050111001426.GF1444@elf.ucw.cz>
References: <7bb8b8de05010710085ea81da9@mail.gmail.com>
	 <20050109224711.GF1353@elf.ucw.cz> <200501092328.54092.shawv@comcast.net>
	 <20050110074422.GA17710@mussel> <20050110105759.GM1353@elf.ucw.cz>
	 <20050110174804.GC4641@blackham.com.au>  <20050111001426.GF1444@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1105405842.2941.1.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 11 Jan 2005 12:10:42 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2005-01-11 at 11:14, Pavel Machek wrote:
> If I do cli(); sleep(5 hours); sti();, system should survive that. If
> you do cli(); sleep(5 hours); sti() but fail to compensate for lost
> ticks, all sorts of funny things might happen if you are comunicating
> with someone who did not sleep.

Wouldn't a thread that did that be fundamentally broken?

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

