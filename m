Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131505AbRDBXvB>; Mon, 2 Apr 2001 19:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131508AbRDBXuv>; Mon, 2 Apr 2001 19:50:51 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:54994 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131505AbRDBXup>;
	Mon, 2 Apr 2001 19:50:45 -0400
Message-ID: <3AC9102C.D053506F@mandrakesoft.com>
Date: Mon, 02 Apr 2001 19:50:04 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-20mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: "J . A . Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] multiline string cleanup
In-Reply-To: <20010330234804.A27780@werewolf.able.es> <oupd7avyng5.fsf@pigdrop.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> "J . A . Magallon" <jamagallon@able.es> writes:
> > This is one other try to make kernel sources gcc-3.0 friendly. This cleans
> > some muti-line asm strings in checksum.h and floppy.h (this were the only
> > ones reported in my kernel build, perhaps there are more in drivers I do
> > not use).

> I surely hope the gcc guys will just remove that silly warning again, because
> it makes it impossible to write readable inline assembly now.

If it's a silly warning, then we should turn it off in linux/Makefile. 
I dunno that the kernel can dictate to gcc here what to do...

Also some multiline string cleanups have already made it into the kernel
-- though that is not conclusive, as it may just be maintainer
preference.

	Jeff


-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full moon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
