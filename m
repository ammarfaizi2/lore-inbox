Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030521AbWFIVg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030521AbWFIVg6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030515AbWFIVg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:36:58 -0400
Received: from relay01.pair.com ([209.68.5.15]:14343 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S1030523AbWFIVg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:36:56 -0400
X-pair-Authenticated: 71.197.50.189
Date: Fri, 9 Jun 2006 16:36:54 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Joel Becker <Joel.Becker@oracle.com>
cc: Theodore Tso <tytso@mit.edu>, Jeff Garzik <jeff@garzik.org>,
       Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
In-Reply-To: <20060609212410.GJ3574@ca-server1.us.oracle.com>
Message-ID: <Pine.LNX.4.64.0606091634340.5541@turbotaz.ourhouse>
References: <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
 <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net>
 <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <m3k67qb7hr.fsf@bzzz.home.net>
 <4489A7ED.8070007@garzik.org> <20060609195750.GD10524@thunk.org>
 <20060609203803.GF3574@ca-server1.us.oracle.com> <20060609210319.GF10524@thunk.org>
 <20060609212410.GJ3574@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jun 2006, Joel Becker wrote:

> 	Heck, forget the name, just make the breakage more explicit.  Do
> it at mkfs/tunefs time.  "tunefs -extents" or "mkfs -t ext3 -extents".
> A mount option assumes that you can do with or without it.  If you do it
> once, you can mount the next time without it and stuff Just Works.  Even
> htree follows this.  A clean unmount leaves a clean directory structure
> that a non-htree driver can use.

I suggested this somewhere back in the thread and it got no play. What's 
the problem with doing things this way? (Aside from it being a compromise 
that doesn't automatically result in a new ext4)

Of course, there are a few debates going on here. Only one of them is 
about compatibility.

>
> Joel
>

Cheers,
Chase
