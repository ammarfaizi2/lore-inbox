Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSFTOCt>; Thu, 20 Jun 2002 10:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSFTOCs>; Thu, 20 Jun 2002 10:02:48 -0400
Received: from ns.suse.de ([213.95.15.193]:47113 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S311749AbSFTOCs>;
	Thu, 20 Jun 2002 10:02:48 -0400
Date: Thu, 20 Jun 2002 16:02:48 +0200
From: Dave Jones <davej@suse.de>
To: Mike Black <mblack@csi-inc.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: 2.5.23 LVM
Message-ID: <20020620160248.H29373@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Mike Black <mblack@csi-inc.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Neil Brown <neilb@cse.unsw.edu.au>
References: <02f101c21858$7970f5f0$f6de11cc@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <02f101c21858$7970f5f0$f6de11cc@black>; from mblack@csi-inc.com on Thu, Jun 20, 2002 at 08:46:18AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 08:46:18AM -0400, Mike Black wrote:
 > FYI...after applying Neil's latest patches for raid got this (not Neil's fault)...I'm not currently using LVM so I disabled it.
 > Good news is that it all compiled (yeah!!! -- first time in months that I've been able to compile with RAID5)
 > Other question -- it looks like the 2.5 build now builds modules automagically instead of saying "make modules" ???
 > Hopefully I'll get chance to test 2.5 soon.
 > 
 > lvm.c:1: #error Broken until maintainers will sanitize kdev_t handling

This is the important line.

There are beginnings of work to fix this in 2.5.23-dj. I imagine the
folks who did those patches will be interested to know how well
it works.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
