Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265030AbUGNQoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265030AbUGNQoV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 12:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265054AbUGNQoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 12:44:20 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:50880 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265030AbUGNQnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 12:43:00 -0400
Date: Wed, 14 Jul 2004 18:42:53 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, akpm@osdl.org, dgilbert@interlog.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH][2.6.8-rc1-mm1] drivers/scsi/sg.c gcc341 inlining fix
Message-ID: <20040714164253.GE7308@fs.tum.de>
References: <200407141216.i6ECGHxg008332@harpo.it.uu.se> <40F556CE.9000707@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F556CE.9000707@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 11:52:46AM -0400, Jeff Garzik wrote:
>...
> If gcc is insisting that prototypes for inlines no longer work, we have 
> a lot of code churn on our hands ;-(  Grumble.

I've counted at about 30 files with such problems in a full i386 
2.6.7-mm7 compile.

I've already sent patches for some of them (e.g. the dmascc.c one), and 
they are usually pretty straightforward.

> 	Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

