Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267184AbUHOV5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267184AbUHOV5w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 17:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267195AbUHOV5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 17:57:51 -0400
Received: from the-village.bc.nu ([81.2.110.252]:16097 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267184AbUHOV5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 17:57:41 -0400
Subject: Re: new tool:  blktool
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
In-Reply-To: <411FD744.2090308@pobox.com>
References: <411FD744.2090308@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092603321.18410.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 15 Aug 2004 21:55:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-08-15 at 22:36, Jeff Garzik wrote:
> 	$ hdparm -c1 /dev/hda
> 		becomes
> 	$ blktool /dev/hda pio-data 32-bit

So you've replaced hdparm's weird but unixish command line with an
even more demented non linuxish one that doesn't handle regexps for
drive names ?

Whatever happened to

	blktool /dev/hda --pio-data=32

