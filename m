Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263545AbTLOOVx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 09:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbTLOOVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 09:21:53 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:20661 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263545AbTLOOVv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 09:21:51 -0500
Date: Mon, 15 Dec 2003 08:21:43 -0600
From: "Jose R. Santos" <jrsantos@austin.ibm.com>
To: "Jose R. Santos" <jrsantos@austin.ibm.com>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       shaggy@austin.ibm.com
Subject: Re: [NFS] Problems with NFS while running SpecSFS with JFS filesystem and 2.6 kernel.
Message-ID: <20031215142143.GA3981@dbz.austin.ibm.com>
References: <20031210144011.GE708@dbz.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20031210144011.GE708@dbz.austin.ibm.com> (from jrsantos@austin.ibm.com on Wed, Dec 10, 2003 at 08:40:11 -0600)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/03 08:40:11, Jose R. Santos wrote:
> The machine I'm using is an old p660 with 8 RS64-IV proc running at 750MHz.
> For IO, I am using 4 FAStT fiber-channel controllers and 8 fiber-channel 
> adapters.  Linux sees 56 disk in total and each disk is actually a RAID5 
> array of 5 disk.

I have manage to reproduce this on a more down-to-earth setup.  I am running
an old RS6k-170 box with one Power3-II chip running at 450MHz and 1Gb RAM. 
In this setup I'm only using two filesystem and the problem still shows up
just about when I'm running out of free pages on the server.

Can anybody provide me with some tips as to how to debug this a bit further?
Really want to figure out if this is a NFS bug or a JFS one.

Thanks

-JRS
