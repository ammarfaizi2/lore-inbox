Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129581AbRCAKe7>; Thu, 1 Mar 2001 05:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129271AbRCAKet>; Thu, 1 Mar 2001 05:34:49 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:54286 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S129552AbRCAKem>; Thu, 1 Mar 2001 05:34:42 -0500
Date: Thu, 1 Mar 2001 13:36:02 +0300
From: Alexander Zarochentcev <zam@namesys.com>
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hans Reiser <reiser@namesys.com>, reiserfs@namesys.com,
        reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] Re: [PATCH] reiserfs patch for linux-2.4.2
Message-ID: <20010301133602.A977@crimson.namesys.com>
In-Reply-To: <20010228222130.A3131@crimson.namesys.com> <20010301013946.X25658@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010301013946.X25658@arthur.ubicom.tudelft.nl>; from J.A.K.Mouw@ITS.TUDelft.NL on Thu, Mar 01, 2001 at 01:39:46AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2001 at 01:39:46AM +0100, Erik Mouw wrote:
> On Wed, Feb 28, 2001 at 10:21:30PM +0300, Alexander Zarochentcev wrote:
> > 6. Using integer constants from limits.h instead of self made ones
> 
> That's a userland header file. Don't use it in the kernel.
> 
> > 7. other minor fixes.
> 
> Does this patch contain Chris Mason's "tail conversion" fix that he
> made after my bug report?

No. 
The "tail conversion" fix was sent to Alan.
It is already included into 2.4.2-ac6.

All fixes are in one combined patch:
ftp://ftp.namesys.com/pub/reiserfs-for-2.4/linux-2.4.2-reiserfs-20010301-full.patch.gz

Tail conversion fix is available as separate patch at namesys.com ftp site:
ftp://ftp.namesys.com/pub/reiserfs-for-2.4/another-null.diff .


> Erik
> 
> -- 
> J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
> of Electrical Engineering, Faculty of Information Technology and Systems,
> Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
> Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
> WWW: http://www-ict.its.tudelft.nl/~erik/

Thanks,
Alex.

