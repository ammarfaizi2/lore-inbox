Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269797AbRHKA2z>; Fri, 10 Aug 2001 20:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270698AbRHKA2p>; Fri, 10 Aug 2001 20:28:45 -0400
Received: from t2.redhat.com ([199.183.24.243]:18160 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S269784AbRHKA2m>; Fri, 10 Aug 2001 20:28:42 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <m1puahzjcn.fsf@frodo.biederman.org> 
In-Reply-To: <m1puahzjcn.fsf@frodo.biederman.org>  <Pine.LNX.3.96.1010730153712.7347D-100000@mandrakesoft.mandrakesoft.com> <20010730140928.D20284@bluemug.com> 
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Mike Touloumtzis <miket@bluemug.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [CFT] initramfs patch 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 11 Aug 2001 01:27:48 +0100
Message-ID: <17412.997489668@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ebiederm@xmission.com said:
>  The current mtd drivers allow exactly this.  Having a filesystem on
> your flash or rom device.  I don't think any filesystem that runs on
> top of them currently supports XIP but the basic infrastructure is
> there. 

Not quite. Hacking romfs to do XIP is trivial but only once we've
implemented the other part of the plan, which is to make MTD drivers 
capable of exporting a new mmzone with their own pages in, for xip-romfs to 
insert into the page cache.

--
dwmw2


