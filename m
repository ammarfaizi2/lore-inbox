Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbTIQTG3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 15:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262840AbTIQTG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 15:06:28 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:32726 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262648AbTIQTG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 15:06:27 -0400
Date: Wed, 17 Sep 2003 21:06:20 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Steve Kieu <haiquy@yahoo.com>
Cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test5  Compile error
Message-ID: <20030917190620.GE8618@fs.tum.de>
References: <20030912211427.18693.qmail@web10407.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030912211427.18693.qmail@web10407.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 07:14:27AM +1000, Steve Kieu wrote:
> 
> Sorry if this has been reported.
> 
> drivers/built-in.o(.text+0x5f34f): In function
> `atkbd_interrupt':
>...

Known problem.

Workaround:
Set
  Input device support
    Serial i/o support (needed for keyboard and mouse)
to "y" instead of "m".

> Build with gcc-2.95.3  . With gcc-3.3.1 it failled
> right the starting point and I forgot to remember :-)

I have no problems compiling 2.6.0-test5 with gcc 3.3.

Please send the complete error message.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

