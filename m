Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129598AbRCPC5G>; Thu, 15 Mar 2001 21:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129624AbRCPC44>; Thu, 15 Mar 2001 21:56:56 -0500
Received: from [198.99.130.100] ([198.99.130.100]:29447 "EHLO karaya.com")
	by vger.kernel.org with ESMTP id <S129598AbRCPC4m>;
	Thu, 15 Mar 2001 21:56:42 -0500
Message-Id: <200103160256.VAA02335@karaya.com>
X-Mailer: exmh version 2.1.1 10/15/1999
To: Dawson Engler <engler@csl.Stanford.EDU>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] big stack variables 
In-Reply-To: Your message of "Thu, 15 Mar 2001 18:34:33 PST."
             <200103160234.SAA03961@csl.Stanford.EDU> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 15 Mar 2001 21:56:10 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

engler@csl.Stanford.EDU said:
> As usual, please report any false positives so we can fix our
> checkers.

Not a false positive, but a false negative:

the tty_struct locals at lines 1994 and 2029 in tty_register_devfs and 
tty_unregister_devfs, respectively, in the 2.4.2 drivers/char/tty_io.c.

Nice work, BTW.

				Jeff


