Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291165AbSBLUPz>; Tue, 12 Feb 2002 15:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291164AbSBLUPp>; Tue, 12 Feb 2002 15:15:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2834 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291165AbSBLUPe>;
	Tue, 12 Feb 2002 15:15:34 -0500
Message-ID: <3C6977A3.1F509184@zip.com.au>
Date: Tue, 12 Feb 2002 12:14:27 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Shawn Starr <spstarr@sh0n.net>
CC: Dag Bakke <dag@bakke.com>, Linux <linux-kernel@vger.kernel.org>,
        xfs <linux-xfs@oss.sgi.com>
Subject: Re: 2.4.18-pre9-xfs-shawn4  -  kmem_cache_alloc oops
In-Reply-To: <20020212141007.B223@dagb>,
		<20020212141007.B223@dagb> <1013523257.262.3.camel@unaropia>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Starr wrote:
> 
> Interesting, I have CONFIG_PNPBIOS on.
> What other filesystems do you have or is it just XFS only?
> 

Known bug in -ac kernels.  It's due to initialisation-order
disagreement between Alan and I.  It looks like Alan has fixed
it in 2.4.18-pre9-ac2.  For earlier -ac's, disable the pnpbios
driver in config.

-
