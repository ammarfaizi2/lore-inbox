Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVG1M4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVG1M4u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 08:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVG1M4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 08:56:50 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25619 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261443AbVG1M4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 08:56:15 -0400
Date: Thu, 28 Jul 2005 14:56:13 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm1 compiles unrequested/unconfigured module!
Message-ID: <20050728125613.GE3528@stusta.de>
References: <20050715013653.36006990.akpm@osdl.org> <20050728125024.GA870@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050728125024.GA870@aitel.hist.no>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2005 at 02:50:24PM +0200, Helge Hafting wrote:

> I usually compile without module support.  This time, I turned modules
> on in order to compile an external module.
> 
> To my surprise, drivers/scsi/qla2xxx/qla2xxx.ko were built even though
> no actual modules are selected in my .config, and the source is
> not patched at all except the mm1 patch.

Known bug, alresdy fixed in -mm3.

> Helge Hafting

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

