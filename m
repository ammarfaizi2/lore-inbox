Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbVGUP1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVGUP1O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 11:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbVGUP1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 11:27:12 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3591 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261797AbVGUPZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 11:25:50 -0400
Date: Thu, 21 Jul 2005 17:25:46 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jesper Juhl <jesper.juhl@gmail.com>, andrew.vasquez@qlogic.com
Cc: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Erik Jacobson <erikj@sgi.com>
Subject: Re: [-mm patch] SCSI_QLA2ABC options must select FW_LOADER
Message-ID: <20050721152546.GG3160@stusta.de>
References: <20050715013653.36006990.akpm@osdl.org> <20050715102744.GA3569@stusta.de> <20050715144037.GA25648@plap.qlogic.org> <dbbg0k$p8g$1@sea.gmane.org> <20050719140419.GI5031@stusta.de> <9a874849050720063872d0c680@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a874849050720063872d0c680@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2005 at 03:38:02PM +0200, Jesper Juhl wrote:
>...
> I send a patch for this yesterday that lets SCSI_QLA2XXX select
> FW_LOADER. I believe that's a bit better since the other options
> depend on SCSI_QLA2XXX anyway, there's no point in having them all set
> FW_LOADER. My patch also fixes another little issue; that you cannot
> disable SCSI_QLA2XXX if you don't need it.
>...

That's not an issue, this seems to be intentional.

Whether SCSI_QLA2XXX should be user-visible (as your patches make it) or 
stay as it is (with the fixes from my patches) doesn't matter much - 
both are valid setups.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

