Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130383AbRCPIXR>; Fri, 16 Mar 2001 03:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130432AbRCPIW5>; Fri, 16 Mar 2001 03:22:57 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:47040 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130383AbRCPIWp>; Fri, 16 Mar 2001 03:22:45 -0500
Message-ID: <3AB1CD91.7C70CD49@uow.edu.au>
Date: Fri, 16 Mar 2001 19:23:45 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Dawson Engler <engler@csl.Stanford.EDU>
CC: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
Subject: Re: [CHECKER] big stack variables
In-Reply-To: <200103160256.VAA02335@karaya.com> from "Jeff Dike" at Mar 15, 2001 09:56:10 PM <200103160719.XAA04602@csl.Stanford.EDU>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dawson Engler wrote:
> 
> Turns out we didn't have CONFIG_DEVFS_FS defined.  Big time fun when it is:
> 
> /u2/engler/mc/2.4.1/drivers/char/tty_io.c:1996:tty_register_devfs: ERROR:VAR:1996:1996: suspicious var 'tty' = 3112 bytes

I've got my nose stuck in tty_io.c at present - I'll fix this this one.
