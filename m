Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263481AbTCNTpE>; Fri, 14 Mar 2003 14:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263482AbTCNTpE>; Fri, 14 Mar 2003 14:45:04 -0500
Received: from packet.digeo.com ([12.110.80.53]:51585 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263481AbTCNTpD>;
	Fri, 14 Mar 2003 14:45:03 -0500
Date: Fri, 14 Mar 2003 11:55:43 -0800
From: Andrew Morton <akpm@digeo.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: adilger@clusterfs.com, bzzz@tmi.comex.ru, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [PATCH] concurrent block allocation for ext2
 against 2.5.64
Message-Id: <20030314115543.4078c581.akpm@digeo.com>
In-Reply-To: <20030314192631.8935342AF9@mx01.nexgo.de>
References: <m3el5bmyrf.fsf@lexa.home.net>
	<m3of4fgjob.fsf@lexa.home.net>
	<20030313165641.H12806@schatzie.adilger.int>
	<20030314192631.8935342AF9@mx01.nexgo.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Mar 2003 19:55:40.0212 (UTC) FILETIME=[B068DF40:01C2EA63]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@arcor.de> wrote:
>
> Ext2 should be thought of as a showcase for best 
> filesystem coding practices.

Yes.  It is the reference block-backed filesystem for the VFS and VM API.  If
a feature is added to core kernel, ext2 gets to use it first, and ext2 is the
place to look to see "how is it done".

Arguably, minixfs should be playing that role, and it is close.  But it is
now missing a few things.

ext2 is also scarily quick.

