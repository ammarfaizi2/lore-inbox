Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbWGCUc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWGCUc0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 16:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWGCUc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 16:32:26 -0400
Received: from tornado.reub.net ([202.89.145.182]:8402 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1751048AbWGCUcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 16:32:25 -0400
Message-ID: <44A97EBA.8070501@reub.net>
Date: Tue, 04 Jul 2006 08:31:54 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060702)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, greg@kroah.com, brice@myri.com
Subject: Re: 2.6.17-mm6
References: <20060703030355.420c7155.akpm@osdl.org>	<44A8F8D2.1030101@reub.net>	<20060703043954.0807c3f2.akpm@osdl.org>	<44A90276.4050108@reub.net> <20060703132104.9b6b85d7.akpm@osdl.org>
In-Reply-To: <20060703132104.9b6b85d7.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/07/2006 8:21 a.m., Andrew Morton wrote:
> On Mon, 03 Jul 2006 23:41:42 +1200
> Reuben Farrelly <reuben-lkml@reub.net> wrote:
> 
>> Allocate Port Service[0000:00:1c.0:pcie0]
>> Allocate Port Service[0000:00:1c.0:pcie0]
> 
> Turns out that we have a rogue patch coming in from the powerpc tree.  This
> should fix it, thanks.
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm6/hot-fixes/git-powerpc-revert-bogus-vsnprintf-change.patch

That has fixed it.  All looking fine now..

reuben
