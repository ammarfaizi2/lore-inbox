Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129197AbRBNLTA>; Wed, 14 Feb 2001 06:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129054AbRBNLSu>; Wed, 14 Feb 2001 06:18:50 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:64572 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129197AbRBNLSN>; Wed, 14 Feb 2001 06:18:13 -0500
Date: Wed, 14 Feb 2001 11:18:06 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.2-pre3: parport_pc init_module bug
Message-ID: <20010214111806.Y9459@redhat.com>
In-Reply-To: <20010214105332.U9459@redhat.com> <Pine.LNX.3.96.1010214051314.12910E-100000@mandrakesoft.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1010214051314.12910E-100000@mandrakesoft.mandrakesoft.com>; from jgarzik@mandrakesoft.mandrakesoft.com on Wed, Feb 14, 2001 at 05:14:19AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2001 at 05:14:19AM -0600, Jeff Garzik wrote:

> Should the call to pci_unregister_driver in cleanup_module be
> conditional on registered_parport as well?  I didn't check...

No. (cleanup_module is only called if init_module succeeded.)

> Also, is it possible to convert parport_pc to new-style module_init()?

Certainly, in 2.5, or when it's needed to fix a bug.

Tim.
*/
