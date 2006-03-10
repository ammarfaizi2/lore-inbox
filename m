Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752058AbWCJHKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbWCJHKp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 02:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752066AbWCJHKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 02:10:44 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:64847 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1752058AbWCJHKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 02:10:44 -0500
Date: Thu, 9 Mar 2006 23:10:39 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Bernd Eckenfels <be-news06@lina.inka.de>
Cc: linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: Re: [Ocfs2-devel] Ocfs2 performance
Message-ID: <20060310071039.GT26764@ca-server1.us.oracle.com>
Mail-Followup-To: Bernd Eckenfels <be-news06@lina.inka.de>,
	linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
References: <20060310002121.GJ27280@ca-server1.us.oracle.com> <E1FHWCm-0002rT-00@calista.inka.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FHWCm-0002rT-00@calista.inka.de>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't drop the ocfs2-devel Cc:  I'm bouncing this there.

On Fri, Mar 10, 2006 at 02:14:08AM +0100, Bernd Eckenfels wrote:
> Mark Fasheh <mark.fasheh@oracle.com> wrote:
> > Your hash sizes are still ridiculously large.
> 
> How long are those entries in the buckets kept? I mean if I untar a tree the
> files are only locked while extracted, afterwards they are owner-less... (I
> must admint I dont understand ocfs2 very deeply, but maybe explaining why so
> many active locks need to be cached might help to find an optimized way.
> 
> > By the way, an interesting thing happened when I recently switched disk
> > arrays - the fluctuations in untar times disappeared. The new array is much
> > nicer, while the old one was basically Just A Bunch Of Disks. Also, sync
> > times dropped dramatically.
> 
> Writeback Cache?
> 
> Gruss
> Bernd
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

"Depend on the rabbit's foot if you will, but remember, it didn't
 help the rabbit."
	- R. E. Shay

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
