Return-Path: <linux-kernel-owner+w=401wt.eu-S1753366AbWLOUGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366AbWLOUGK (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 15:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753369AbWLOUGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 15:06:10 -0500
Received: from smtp.osdl.org ([65.172.181.25]:40382 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753366AbWLOUGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 15:06:08 -0500
Date: Fri, 15 Dec 2006 12:06:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jurriaan <thunder7@xs4all.nl>
Cc: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: md patches in -mm
Message-Id: <20061215120603.41ff6fed.akpm@osdl.org>
In-Reply-To: <20061215192146.GA3616@amd64.of.nowhere>
References: <20061204203410.6152efec.akpm@osdl.org>
	<17780.63770.228659.234534@cse.unsw.edu.au>
	<20061205061623.GA13749@amd64.of.nowhere>
	<20061205062142.GA14784@amd64.of.nowhere>
	<20061204224323.2e5d0494.akpm@osdl.org>
	<20061205105928.GA6482@amd64.of.nowhere>
	<17782.28505.303064.964551@cse.unsw.edu.au>
	<20061215192146.GA3616@amd64.of.nowhere>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2006 20:21:46 +0100
thunder7@xs4all.nl wrote:

> From: Neil Brown <neilb@suse.de>
> Date: Wed, Dec 06, 2006 at 06:20:57PM +1100
> > i.e. current -mm is good for 2.6.20 (though I have a few other little
> > things I'll be sending in soon, they aren't related to the raid6
> > problem).
> > 
> 2.6.20-rc1-mm1 doesn't boot on my box, due to the fact that e2fsck gives
> 
> Buffer I/O error on device /dev/md0, logical block 0
> 
> and after that 1,2,3,4,5,6,7,8,9, at which points it complains it can't
> read the superblock. It seems the raid6 problem hasn't gone away
> completely, after all.

Odd.  The only md patch in rc1-mm1 is the truly ancient 
md-dm-reduce-stack-usage-with-stacked-block-devices.patch

Does 2.6.20-rc1 work?
