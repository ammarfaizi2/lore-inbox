Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292231AbSBOWcJ>; Fri, 15 Feb 2002 17:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292244AbSBOWaq>; Fri, 15 Feb 2002 17:30:46 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:40207 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S292227AbSBOWa0>; Fri, 15 Feb 2002 17:30:26 -0500
Date: Fri, 15 Feb 2002 23:30:21 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] queue barrier support
Message-ID: <20020215223021.GA12204@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3998280000.1013790514@tiny> <200202151651.g1FGpjs02083@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200202151651.g1FGpjs02083@localhost.localdomain>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2002, James Bottomley wrote:

> Note also that on system shutdown, most devices that use write back caching 
> are also expecting a cache flush instruction from the node, which Linux 
> doesn't send.

Hair splitting: it looks as though Andre Hedrick's IDE patch did this at
least. Of course, that does not affect SCSI drives, but since you wrote
"Linux", I thought this could be mentioned in this thread again. At
least, my ATA drives are powered down some seconds before my ATX PC is,
and the kernel says about flushing the cache.

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
