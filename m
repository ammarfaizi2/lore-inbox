Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265337AbSJRW6f>; Fri, 18 Oct 2002 18:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265341AbSJRW6e>; Fri, 18 Oct 2002 18:58:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22020 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265337AbSJRW6e>;
	Fri, 18 Oct 2002 18:58:34 -0400
Message-ID: <3DB09384.10403@pobox.com>
Date: Fri, 18 Oct 2002 19:04:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: trelane@digitasaru.net
CC: linux-kernel@vger.kernel.org
Subject: Re: i2c-elektor (2.5.43) non-fatal error: unresolved symbol cli,
 sti
References: <20021018224835.GC31649@digitasaru.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Pingenot wrote:
> I didn't see this, so I'm reporting it:
> make -f arch/i386/lib/Makefile modules_install
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.43; fi
> depmod: *** Unresolved symbols in /lib/modules/2.5.43/kernel/drivers/i2c/i2c-elektor.o
> depmod:         cli
> depmod:         sti
> 
> Looks like a problem in the i2c-elektor driver.


It's one of several drivers that have not been updated since cli/sti 
were removed...

