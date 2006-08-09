Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbWHIVV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWHIVV3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 17:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWHIVV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 17:21:28 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60945 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751379AbWHIVV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 17:21:28 -0400
Date: Wed, 9 Aug 2006 23:21:24 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: /dev/sd*
Message-ID: <20060809212124.GC3691@stusta.de>
References: <1155144599.5729.226.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155144599.5729.226.camel@localhost.localdomain>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 06:29:59PM +0100, Alan Cox wrote:
>...
> - Drives appear as /dev/sda /dev/sr0 etc along with the libata SATA
> devices (and since you can't tell SATA from PATA at times its hard to
> avoid). That means people with some older distros wanting to try it
> might need to change their fstab or rootdev. People not trying it won't
> be affected.
>...

It might be a bit out of the scope of this thread, but why do some many 
subsystems use the /dev/sd* namespace?

Real SCSI devices use it.
The USB mass storage driver uses it.
libata uses it.

I'd expext SATA or PATA devices at /dev/hd* or perhaps at /dev/ata* - 
but why are they at /dev/sd*?

> Alan

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

