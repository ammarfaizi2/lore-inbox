Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965749AbWKHNeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965749AbWKHNeF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 08:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965744AbWKHNeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 08:34:05 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:40837 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965749AbWKHNeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 08:34:02 -0500
Message-ID: <4551DCBE.1060508@garzik.org>
Date: Wed, 08 Nov 2006 08:33:50 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Daniel J Blueman <daniel.blueman@gmail.com>, Andrew Morton <akpm@osdl.org>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, nfsv4@linux-nfs.org,
       Neil Brown <neilb@suse.de>, "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Fwd: [PATCH 2/2] nfsd4: fix open-create permissions
References: <6278d2220611060403j2b63cb9cl1d0707e7cf3d7899@mail.gmail.com>	 <20061106161747.GA12372@fieldses.org>	 <20061106162458.GC12372@fieldses.org> <6278d2220611060848n3585ebc5odbf39efd6a02ab2@mail.gmail.com>
In-Reply-To: <6278d2220611060848n3585ebc5odbf39efd6a02ab2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel J Blueman wrote:
> Linus, Trond,
> 
> What is the chance of this patch making it into the final 2.6.19?
> 
> WIthout it, there is a serious NFSv4 open() regression; I've been
> running it on client and server for ~1 week under load and it resolves
> the condition w/o side-effects. See the LKML thread "Poor NFSv4 first
> impressions" for further details.

strong ACK, provided that someone who knows the NFSv4 server code well 
(Neil B?) gives it an ACK.

	Jeff



