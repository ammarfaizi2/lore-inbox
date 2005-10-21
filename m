Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965196AbVJUXp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965196AbVJUXp3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 19:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965195AbVJUXp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 19:45:29 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2059 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965090AbVJUXp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 19:45:28 -0400
Date: Sat, 22 Oct 2005 01:45:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Roger While <simrw@sim-basis.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 - SCSI Config parameter always set ?
Message-ID: <20051021234526.GD5432@stusta.de>
References: <6.1.1.1.2.20051014154955.026f38e0@192.168.6.2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6.1.1.1.2.20051014154955.026f38e0@192.168.6.2>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2005 at 03:50:33PM +0200, Roger While wrote:
> CONFIG_SCSI_QLA2XXX=y
> 
> It seems as though this is always set with no method
> of unsetting it.

Disable CONFIG_SCSI or CONFIG_PCI...  ;-)

> Is this intentional ?

Yes, it is.

Note that CONFIG_SCSI_QLA2XXX itself doesn't enable any code, it's only 
a herlper option for the other SCSI_QLA2* options.

> It's been like this since at least 2.6.11 up to current 2.6.14rc4.
> 
> Roger While

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

