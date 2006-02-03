Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWBCRvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWBCRvV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 12:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWBCRvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 12:51:21 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:9615 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP
	id S1751280AbWBCRvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 12:51:20 -0500
Date: Fri, 3 Feb 2006 18:51:11 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Phillip Susi <psusi@cfl.rr.com>
cc: Bill Davidsen <davidsen@tmr.com>, Cynbe ru Taren <cynbe@muq.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
In-Reply-To: <Pine.LNX.4.60.0602031654520.24081@kepler.fjfi.cvut.cz>
Message-ID: <Pine.LNX.4.60.0602031846510.24081@kepler.fjfi.cvut.cz>
References: <E1EywcM-0004Oz-IE@laurel.muq.org> <20060117193913.GD3714@kvack.org>
 <Pine.LNX.4.60.0601172047560.25680@kepler.fjfi.cvut.cz> <43E26CB6.7030808@tmr.com>
 <Pine.LNX.4.60.0602030037520.18478@kepler.fjfi.cvut.cz> <43E379C2.2020607@cfl.rr.com>
 <Pine.LNX.4.60.0602031654520.24081@kepler.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2006, Martin Drab wrote:

> On Fri, 3 Feb 2006, Phillip Susi wrote:
> 
> > Usually drives will fail reads to bad sectors but when you write to that
> > sector, it will write and read that sector to see if it is fine after being
> > written again, or if the media is bad in which case it will remap the sector
> > to a spare. 
> 
> No, I don't think this was the case of a physically bad sectors. I think 
> it was just an inconsistency of the RAID controllers metadata (or 
> something simillar) related to that particular array.

Or is such a situation not possible at all? Are bad sectors the only 
reason that might have caused this? That sounds a little strange to me, 
that would have been a very unlikely concentration of conincidences, IMO. 
That's why I still think there are no bad sectors at all (at least not 
because of this). Is there any way to actually find out?

Martin
