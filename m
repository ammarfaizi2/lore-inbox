Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264986AbTBFGNs>; Thu, 6 Feb 2003 01:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265506AbTBFGNs>; Thu, 6 Feb 2003 01:13:48 -0500
Received: from packet.digeo.com ([12.110.80.53]:53426 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264986AbTBFGNr>;
	Thu, 6 Feb 2003 01:13:47 -0500
Date: Wed, 5 Feb 2003 22:23:50 -0800
From: Andrew Morton <akpm@digeo.com>
To: thunder7@xs4all.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 won't boot, 2.5.58 will, how to I use bitkeeper to get
 'in between' ?
Message-Id: <20030205222350.77e50934.akpm@digeo.com>
In-Reply-To: <20030206060742.GA6458@middle.of.nowhere>
References: <20030206060742.GA6458@middle.of.nowhere>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Feb 2003 06:23:17.0891 (UTC) FILETIME=[3CD9ED30:01C2CDA8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurriaan <thunder7@xs4all.nl> wrote:
>
> Until now, all 2.5.59-based kernels (2.5.59 vanilla, 2.5.59 + vmlinux
> patch, 2.5.59-mm[1-8]) hang very early in the boot-process on my system,
> right after 'Uncompressing Linux...'
> 
> I am willing to try which patch between 2.5.58 and 2.5.59 caused this,
> but I can't find out how to extract these patches. If I browse the
> linux-2.5 repository on the web-interface @ bitkeeper, I don't see a
> message 'And with this patch-set, we've reached 2.5.58 - any patches
> after this apply to 2.5.58 and will create 2.5.59 in due time'.
> 
> /usr/src/linux/Documentation/BK-usage/ seems to focus more on uploading
> patches. There is something on getting the diff between two kernel
> versions, but I need finer patches/revisions/changesets. I can see how
> to download the initial tree, but what do I do next?
> 

I've been regularly snarfing the rollups from 
http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/
for this very purpose.

Over at http://www.zip.com.au/~akpm/linux/patches/2.5/x/

You will find 15 patches, spread across the lifetime of the 2.5.58->2.5.59
cycle.

If you can identify which of those patches introduced the failure...


