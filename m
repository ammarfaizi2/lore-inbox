Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269676AbTHJO6i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 10:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269685AbTHJO6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 10:58:37 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:50923 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S269676AbTHJO6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 10:58:24 -0400
Date: Sun, 10 Aug 2003 16:58:16 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Adam Langley <agl@imperialviolet.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3 compile failure
Message-ID: <20030810145816.GZ16091@fs.tum.de>
References: <20030810135159.GA29034@linuxpower.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030810135159.GA29034@linuxpower.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 02:51:59PM +0100, Adam Langley wrote:

> drivers/built-in.o(.text+0x65698): In function `atkbd_interrupt':
> : undefined reference to `serio_rescan'
>...
> .config file is at http://www2.doc.ic.ac.uk/~agl02/2.6.0-test3-config

Thanks for your report.

This is a known problem, as a workaound, compile

  Input device support
    Serial i/o support (needed for keyboard and mouse)

statically (non-modular) into the kernel.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

