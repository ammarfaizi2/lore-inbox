Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753491AbWKFRmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491AbWKFRmJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 12:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753554AbWKFRmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 12:42:09 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:29774 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1753491AbWKFRmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 12:42:06 -0500
In-Reply-To: <adaodrko6vq.fsf@cisco.com>
Subject: Re: [PATCH 2.6.19 1/4] ehca: assure 4k alignment for firmware control block
 in 64k page mode
To: Roland Dreier <rdreier@cisco.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Raisch <raisch@de.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openib-general@openib.org, rolandd@cisco.com
X-Mailer: Lotus Notes Release 7.0 HF277 June 21, 2006
Message-ID: <OFB9DD8741.750AEF46-ONC125721E.00610BD7-C125721E.00613BC8@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Mon, 6 Nov 2006 18:45:04 +0100
X-MIMETrack: Serialize by Router on D12ML065/12/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 06/11/2006 18:45:06
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roland!
>  > As Arnd stated I need to fix this ctor issue. Do you prefer me to
resend
>  > all patches in proper format (non-mangled inline) or just this one bug
fix?
> I have the rest of the patches, so you just need to resend a fixed
> version of this one.  BTW see my previous response about
> kmem_cache_zalloc() -- I think that's the best way to fix this.
Yes. This makes sense to me. Will send this one patch soon.
> In the future though if you can make a patch-sending script or
> something that lets you avoid the attachments that would be great.
Sure, will do. I just found out that I'm using an old version of
kmail and its editor (all fancy editing is turned off, just plain text)
just manngles leading and trailing tabs and spaces...
Thanks
Nam

