Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVCaVIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVCaVIW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 16:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVCaVIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 16:08:21 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:5903 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261932AbVCaVHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 16:07:51 -0500
Date: Thu, 31 Mar 2005 23:07:45 +0200
From: Adrian Bunk <bunk@stusta.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] SCSI: cleanups
Message-ID: <20050331210745.GH3185@stusta.de>
References: <20050327202139.GQ4285@stusta.de> <1112023305.5531.2.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112023305.5531.2.camel@mulgrave>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 09:21:45AM -0600, James Bottomley wrote:
> On Sun, 2005-03-27 at 22:21 +0200, Adrian Bunk wrote:
> > This patch contains the following cleanups:
> [..]
> 
> No to all of this:
> 
> > - remove the following unused functions:
> >   - scsi.h: print_driverbyte
> >   - scsi.h: print_hostbyte
> > - #if 0 the following unused functions:
> >   - constants.c: scsi_print_hostbyte
> >   - constants.c: scsi_print_driverbyte
> 
> These are useful to those of us who debug drivers.
>...

Does this really include the legacy print_driverbyte and print_hostbyte 
wrappers?

> James

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

