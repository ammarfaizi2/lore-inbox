Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbVKRQnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbVKRQnM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 11:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbVKRQnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 11:43:12 -0500
Received: from [217.149.127.10] ([217.149.127.10]:27357 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP id S964787AbVKRQnL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 11:43:11 -0500
Date: Fri, 18 Nov 2005 17:42:27 +0100
From: Ragnar =?iso-8859-15?Q?Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, Badari Pulavarty <pbadari@us.ibm.com>,
       andrea@suse.de, hugh@veritas.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC] sys_punchhole()
Message-ID: <20051118164227.GA14697@vestdata.no>
References: <1131664994.25354.36.camel@localhost.localdomain> <20051110153254.5dde61c5.akpm@osdl.org> <20051113150906.GA2193@spitz.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051113150906.GA2193@spitz.ucw.cz>
User-Agent: Mutt/1.4.1i
X-Zet.no-MailScanner-Information: Please contact the ISP for more information
X-Zet.no-MailScanner: Found to be clean
X-MailScanner-From: ragnark@stine.vestdata.no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2005 at 03:09:06PM +0000, Pavel Machek wrote:
> > > We discussed this in madvise(REMOVE) thread - to add support 
> > > for sys_punchhole(fd, offset, len) to complete the functionality
> > > (in the future).
> > > 
> > > http://marc.theaimsgroup.com/?l=linux-mm&m=113036713810002&w=2
> > > 
> > > What I am wondering is, should I invest time now to do it ?
> > 
> > I haven't even heard anyone mention a need for this in the past 1-2 years.
> 
> Some database people wanted it maybe month ago. It was replaced by some 
> madvise hack...


sys_punchhole is also potentially very useful for Hirarchial Storage
Management. (Holes are typically used for data that have been migrated
to tape).




-- 
Ragnar Kjørstad
