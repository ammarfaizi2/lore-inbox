Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129719AbRCPDIQ>; Thu, 15 Mar 2001 22:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129694AbRCPDIH>; Thu, 15 Mar 2001 22:08:07 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:34978 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129719AbRCPDH6>; Thu, 15 Mar 2001 22:07:58 -0500
Message-ID: <3AB1834B.DF424C26@uow.edu.au>
Date: Fri, 16 Mar 2001 03:06:51 +0000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.2-ac19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Dike <jdike@karaya.com>
CC: Dawson Engler <engler@csl.Stanford.EDU>, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] big stack variables
In-Reply-To: <200103160256.VAA02335@karaya.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:
> 
> engler@csl.Stanford.EDU said:
> > As usual, please report any false positives so we can fix our
> > checkers.
> 
> Not a false positive, but a false negative:
> 
> the tty_struct locals at lines 1994 and 2029 in tty_register_devfs and
> tty_unregister_devfs, respectively, in the 2.4.2 drivers/char/tty_io.c.

and sanitize_e820_map()

> Nice work, BTW.

Yep.

-
