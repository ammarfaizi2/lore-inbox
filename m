Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270367AbTHBTtL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 15:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270370AbTHBTtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 15:49:10 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:13053 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S270367AbTHBTsm (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 15:48:42 -0400
Date: Sat, 2 Aug 2003 21:48:34 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: John Bradford <john@grabjohn.com>
Cc: szepe@pinerecords.com, Linux-Kernel@vger.kernel.org, Riley@Williams.Name
Subject: Re: [2.6 patch] let broken drivers depend on BROKEN{,ON_SMP}
Message-ID: <20030802194834.GG16426@fs.tum.de>
References: <200307310941.h6V9fGIL000804@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307310941.h6V9fGIL000804@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 10:41:16AM +0100, John Bradford wrote:
>...
> Also, remember that some things might only give compile errors under
> certain circumstances.  The _vast_ majority of kernels include TCP/IP
> support, for example, so something that breaks when it's not
> configured could easily go unnoticed for ages - does that mean it
> should be put behind CONFIG_BROKEN when it's discovered?

Most such issues aren't hard to fix once they are discovered.

Most broken drivers in 2.6 are different: They need a big amount of
non-trivial work to get them fixed.

> John.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

