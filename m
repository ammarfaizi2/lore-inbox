Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263064AbUCYB3N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 20:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbUCYB3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 20:29:13 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:62932 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262618AbUCYB3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 20:29:08 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Evan Felix <evan.felix@pnl.gov>
Date: Thu, 25 Mar 2004 12:28:57 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16482.13785.605678.313900@notabene.cse.unsw.edu.au>
Cc: Nathan D Tenney <Nathan.Tenney@pnl.gov>,
       linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       hpa@zytor.com (H. Peter Anvin)
Subject: Re: Raid Array with 3.5Tb
In-Reply-To: message from Evan Felix on Monday March 22
References: <1074196167.1382.8.camel@e-linux>
	<16391.51319.698137.120756@notabene.cse.unsw.edu.au>
	<1079974452.13232.10.camel@e-linux>
        <1080162888.1936.15.camel@e-linux>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday March 22, evan.felix@pnl.gov wrote:
> Remember the 3.5Tb Array i've been trying to build, i finally got around
> to getting some source code changes that seem to work much better. 
> Attached you will find a patch that fixes the raid5 code to a point
> where it seems to re-sync and recover without complaining about maps not
> being correct.  The patch below is build against a 2.6.3, but will patch
> 2.6.4 sources as well.  At this point i'd like to hear comments,
> thoughts on the changes i've made.  Some notes:
> 
> 1. raid0 seems to work fine at 3.5T
> 2. I have not looked at the raid6 code, but it does not work at 3.5Tb
> 3. Formatting the array with ext3 takes a very long time, not sure why
> yet.

Thanks.
I've added the equivalent changes to raid6 (to keep 5 and 6 in-sync)
and forwarded it to Andrew.

NeilBrown
