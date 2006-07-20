Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030326AbWGTXKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbWGTXKs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 19:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030336AbWGTXKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 19:10:48 -0400
Received: from lucidpixels.com ([66.45.37.187]:38630 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1030326AbWGTXKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 19:10:47 -0400
Date: Thu, 20 Jul 2006 19:10:46 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Nathan Scott <nathans@sgi.com>
cc: Chris Wedgwood <cw@f00f.org>, David Greaves <david@dgreaves.com>,
       Kasper Sandberg <lkml@metanurb.dk>,
       Torsten Landschoff <torsten@debian.org>, linux-kernel@vger.kernel.org,
       xfs@oss.sgi.com, ml@magog.se, radsaq@gmail.com
Subject: Re: FAQ updated (was Re: XFS breakage...)
In-Reply-To: <20060721090015.G1990742@wobbly.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.64.0607201910010.20652@p34.internal.lan>
References: <1153304468.3706.4.camel@localhost> <20060720171310.B1970528@wobbly.melbourne.sgi.com>
 <44BF8500.1010708@dgreaves.com> <20060720161121.GA26748@tuatara.stupidest.org>
 <20060721081452.B1990742@wobbly.melbourne.sgi.com>
 <Pine.LNX.4.64.0607201817450.23697@p34.internal.lan>
 <20060721082448.C1990742@wobbly.melbourne.sgi.com>
 <Pine.LNX.4.64.0607201843020.2619@p34.internal.lan>
 <20060721085230.F1990742@wobbly.melbourne.sgi.com>
 <Pine.LNX.4.64.0607201855270.2652@p34.internal.lan>
 <20060721090015.G1990742@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan,

Running xfs_repair multiple times (after following the FAQ for the 
write core.mode 0 fix), I get this:

         - agno = 3
         - agno = 4
         - agno = 5
         - agno = 6
entry ".." at block 0 offset 1352 in directory inode 3221227534 references 
free inode 2112
         clearing inode number in entry at offset 1352...
no .. entry for directory 3221227534
         - agno = 7
         - agno = 8
         - agno = 9
disconnected inode 2684386082, moving to lost+found
disconnected inode 2684386083, moving to lost+found
disconnected inode 2684386084, moving to lost+found
disconnected inode 2684386085, moving to lost+found
disconnected inode 2684386086, moving to lost+found
disconnected inode 2684386087, moving to lost+found
disconnected inode 2684386088, moving to lost+found
disconnected inode 2684386089, moving to lost+found
disconnected inode 2684386090, moving to lost+found
disconnected inode 2684386091, moving to lost+found
disconnected inode 2684386092, moving to lost+found
disconnected inode 2684386093, moving to lost+found
disconnected inode 2684386094, moving to lost+found
disconnected inode 2684386095, moving to lost+found
disconnected inode 2684386096, moving to lost+found
disconnected inode 2684386097, moving to lost+found
disconnected inode 2684386098, moving to lost+found
disconnected inode 2684386099, moving to lost+found
disconnected inode 2684386100, moving to lost+found
disconnected inode 2684386101, moving to lost+found
disconnected inode 2684386102, moving to lost+found
disconnected inode 2684386103, moving to lost+found
disconnected inode 2684386104, moving to lost+found
disconnected inode 2684386105, moving to lost+found
disconnected inode 2684386106, moving to lost+found
disconnected inode 2684386107, moving to lost+found
disconnected inode 2684386108, moving to lost+found
disconnected inode 2684386109, moving to lost+found
disconnected inode 2684386110, moving to lost+found
disconnected inode 2684386111, moving to lost+found
disconnected inode 2684386112, moving to lost+found
disconnected inode 2684386113, moving to lost+found
disconnected inode 2684386114, moving to lost+found
disconnected inode 2684386115, moving to lost+found
disconnected inode 2684386116, moving to lost+found
disconnected inode 2684386117, moving to lost+found
disconnected inode 2684386118, moving to lost+found
disconnected inode 2684386119, moving to lost+found
disconnected inode 2684386120, moving to lost+found
disconnected inode 2684386121, moving to lost+found
disconnected inode 2684386122, moving to lost+found
disconnected inode 2684386123, moving to lost+found
disconnected inode 2684386124, moving to lost+found
disconnected inode 2684386125, moving to lost+found
disconnected inode 2684386126, moving to lost+found
disconnected inode 2684386127, moving to lost+found
disconnected inode 2684386128, moving to lost+found
disconnected inode 2684386129, moving to lost+found
disconnected inode 2684386130, moving to lost+found
disconnected inode 2684386131, moving to lost+found
disconnected inode 2684386132, moving to lost+found
disconnected inode 2684386133, moving to lost+found
disconnected inode 2684386134, moving to lost+found
disconnected inode 2684386135, moving to lost+found
disconnected inode 2684386136, moving to lost+found
disconnected inode 2684386137, moving to lost+found
disconnected inode 2684386138, moving to lost+found
disconnected inode 2684386139, moving to lost+found
disconnected inode 2684386140, moving to lost+found
disconnected inode 2684386141, moving to lost+found
disconnected inode 2684386142, moving to lost+found
disconnected inode 2684386143, moving to lost+found
disconnected inode 2684386144, moving to lost+found
disconnected inode 2684386145, moving to lost+found
disconnected inode 2684386146, moving to lost+found
disconnected inode 2684386147, moving to lost+found
disconnected inode 2684386148, moving to lost+found
disconnected inode 2684386149, moving to lost+found
disconnected inode 2684386150, moving to lost+found
disconnected inode 2684386151, moving to lost+found
disconnected inode 2684386152, moving to lost+found
disconnected inode 2684386153, moving to lost+found
disconnected inode 2684386154, moving to lost+found
disconnected inode 2684386155, moving to lost+found
disconnected inode 2684386156, moving to lost+found
disconnected inode 2684386157, moving to lost+found
disconnected inode 2684386158, moving to lost+found
disconnected inode 2684386159, moving to lost+found
disconnected inode 2684386160, moving to lost+found
disconnected inode 2684386161, moving to lost+found
disconnected inode 2684386162, moving to lost+found
disconnected inode 2684386163, moving to lost+found
disconnected inode 2684386164, moving to lost+found
disconnected inode 2684386165, moving to lost+found
disconnected inode 2684653605, moving to lost+found
disconnected dir inode 3221227534, moving to lost+found
Phase 7 - verify and correct link counts...
resetting inode 3221227534 nlinks from 3 to 2
done
p34:~#

I can run this over and over, and the result is the same?

On Fri, 21 Jul 2006, Nathan Scott wrote:

> On Thu, Jul 20, 2006 at 06:55:51PM -0400, Justin Piszcz wrote:
>> Phase 6 - check inode connectivity...
>>          - traversing filesystem starting at / ...
>> free block 16777216 for directory inode 2684356622 bad nused
>> free block 16777216 for directory inode 2147485710 bad nused

>>          - traversal finished ...
>> ...
>> I applied the "one line fix" - I should be ok now?
>
> You have two corrupt directory inodes (caused by this bug, that
> is exactly the signature I'd expect - it was a nused field that
> was affected by the dodgey endian change).  The two inodes need
> to be fixed - consult the FAQ for details.
>
> Once fixed, and with a patched kernel, you're set.
>
> cheers.
>
> -- 
> Nathan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
