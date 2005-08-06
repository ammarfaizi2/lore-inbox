Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbVHFL64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbVHFL64 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 07:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbVHFL64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 07:58:56 -0400
Received: from cantor2.suse.de ([195.135.220.15]:14767 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262190AbVHFL6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 07:58:51 -0400
Date: Sat, 6 Aug 2005 13:58:36 +0200
From: Andi Kleen <ak@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Zachary Amsden <zach@vmware.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 8/8 Create MMU 2/3 level accessors in the sub-arch layer  (i386)
Message-ID: <20050806115836.GN8266@wotan.suse.de>
References: <42F46558.9010202@vmware.com.suse.lists.linux.kernel> <p73wtmz1ekk.fsf@bragg.suse.de> <20050806115619.GA1560@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050806115619.GA1560@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I think that patch is really ugly - it makes hacking VM on i386
> > even more painful than it already is because the convolutes the file
> > structure even more. Hope it is not applied.
> 
> Especially as there's been no user shown for it, similar to all the other
> ugly patches from vmware.

Well, some of it can be counted as cleanup or even tuning like the excellent
switch_to patch. But not that one and some of the more intrusive patches.

-Andi

> 
