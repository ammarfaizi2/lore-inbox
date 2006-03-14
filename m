Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751910AbWCNVb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbWCNVb7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 16:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWCNVb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 16:31:59 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53770 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751910AbWCNVb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 16:31:58 -0500
Date: Tue, 14 Mar 2006 22:31:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Stone, Joshua I" <joshua.i.stone@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Exports for hrtimer APIs
Message-ID: <20060314213156.GU13973@stusta.de>
References: <CBDB88BFD06F7F408399DBCF8776B3DC06A92A64@scsmsx403.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CBDB88BFD06F7F408399DBCF8776B3DC06A92A64@scsmsx403.amr.corp.intel.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 01:15:52PM -0800, Stone, Joshua I wrote:
>...
> If SystemTap is to be able to make use of hrtimers, the only alternative
> I see is to create our own APIs in the tree that wrap hrtimer, and then
> export those.  This seems much less sensible than just exporting what is
> already there...

The question is if the exports you want to add to the kernel are 
acceptable or not.

If the answer would be "no", trying to threaten with this kind of cheap 
tricks is silly since the answer to your exported wrappers would be the 
same as for the direct exports.

> Josh

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

