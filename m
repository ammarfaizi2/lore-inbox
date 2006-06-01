Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965245AbWFAFod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965245AbWFAFod (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 01:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965247AbWFAFod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 01:44:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:58795 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965243AbWFAFoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 01:44:32 -0400
From: Neil Brown <neilb@suse.de>
To: Chris Wright <chrisw@sous-sol.org>
Date: Thu, 1 Jun 2006 15:44:19 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17534.32435.740138.527260@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 008 of 10] md: Allow raid 'layout' to be read and set via sysfs.
In-Reply-To: message from Chris Wright on Wednesday May 31
References: <20060601150955.27444.patches@notabene>
	<1060601051408.27637@suse.de>
	<20060601053459.GL2697@moss.sous-sol.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday May 31, chrisw@sous-sol.org wrote:
> * NeilBrown (neilb@suse.de) wrote:
> > +static struct md_sysfs_entry md_layout =
> > +__ATTR(layout, 0655, layout_show, layout_store);
> 
> 0644?

I think the correct response is "Doh!" :-)

Yes, thanks,
NeilBrown
