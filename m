Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289836AbSAWMqd>; Wed, 23 Jan 2002 07:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289837AbSAWMqO>; Wed, 23 Jan 2002 07:46:14 -0500
Received: from mail002.syd.optusnet.com.au ([203.2.75.245]:21661 "EHLO
	mail002.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S289836AbSAWMqF>; Wed, 23 Jan 2002 07:46:05 -0500
Date: Wed, 23 Jan 2002 20:45:50 +0800
From: Michal Gornisiewicz <michal@tartarus.uwa.edu.au>
To: Joel Cordonnier <joel_linuxfr@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unable to mount root fs / reiserfs /HELP please
Message-ID: <20020123124550.GB4375@tartarus.uwa.edu.au>
In-Reply-To: <20020123113048.82063.qmail@web13006.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020123113048.82063.qmail@web13006.mail.yahoo.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel,

On Wed, Jan 23, 2002 at 12:30:48PM +0100, Joel Cordonnier wrote:
> I just compile a 2.4.15 kernel on my HP omnibook XE3.
> At the moment, I have a dual partition win2k/suse 7.3.
> 
*snip*
>
> I have read that reiserfs is not supported for a
> 'default' kernel and that i have to include
> patches...right `?

Reiserfs has been in the main kernel since 2.4.1-pre4. All you need to
do is enable it when you compile the kernel. The option is
CONFIG_REISERFS_FS under File Systems. You will need to compile it into
the kernel, not as a module to boot your root file system.

Also, make sure you have a recent version of lilo, with reiserfs support.


MG
