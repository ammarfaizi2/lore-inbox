Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288561AbSADJ3v>; Fri, 4 Jan 2002 04:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288562AbSADJ3p>; Fri, 4 Jan 2002 04:29:45 -0500
Received: from dark.pcgames.pl ([195.205.62.2]:20917 "EHLO dark.pcgames.pl")
	by vger.kernel.org with ESMTP id <S288561AbSADJ3h>;
	Fri, 4 Jan 2002 04:29:37 -0500
Date: Fri, 4 Jan 2002 10:28:18 +0100 (CET)
From: Krzysztof Oledzki <ole@ans.pl>
X-X-Sender: <ole@dark.pcgames.pl>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Two hdds on one channel - why so slow?
In-Reply-To: <Pine.LNX.4.33.0201021452120.8693-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.33.0201041017570.12882-100000@dark.pcgames.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 Jan 2002, Mark Hahn wrote:

>
> yes, I know what he said.  it's true that there's no concurrency,
> but he's wrong about expecting half (due to readahead/writebehind),
> and there's no real overhead in switching.
So why my disks work with ~12MB/sec per device (~24 per channel) when
both HDDs are accessed on the sime time?

> in short, master-slave concurrency is not common (but definitely
> supported by the standard and some disks), but this has less
> effect than you'd think.  especially since most people just
> treat ide as a single-drive ptp link.  which works fine, since
> ide channels cost $15 or less, and ide disks are *so* much cheaper
> than scsi.

Yes. IDE as a PtP device works nice. But this means that in most cases
it is possible to connect only half of expected devices. What a pity :(


Best regards,


				Krzysztof Oldzki

