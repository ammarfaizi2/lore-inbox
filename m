Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbVHFMBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVHFMBt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 08:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVHFMBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 08:01:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:19079 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262188AbVHFMBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 08:01:44 -0400
Date: Sat, 6 Aug 2005 13:01:41 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, Zachary Amsden <zach@vmware.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 8/8 Create MMU 2/3 level accessors in the sub-arch layer  (i386)
Message-ID: <20050806120141.GA1827@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@suse.de>, Zachary Amsden <zach@vmware.com>,
	linux-kernel@vger.kernel.org
References: <42F46558.9010202@vmware.com.suse.lists.linux.kernel> <p73wtmz1ekk.fsf@bragg.suse.de> <20050806115619.GA1560@infradead.org> <20050806115836.GN8266@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050806115836.GN8266@wotan.suse.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2005 at 01:58:36PM +0200, Andi Kleen wrote:
> > > I think that patch is really ugly - it makes hacking VM on i386
> > > even more painful than it already is because the convolutes the file
> > > structure even more. Hope it is not applied.
> > 
> > Especially as there's been no user shown for it, similar to all the other
> > ugly patches from vmware.
> 
> Well, some of it can be counted as cleanup or even tuning like the excellent
> switch_to patch. But not that one and some of the more intrusive patches.

Yeah, I said ugly ones specificly.  There's been some nice previous ones,
but most in this series (all the move of stuff to subarches) are rather
horrible and lack lots of explanation.

