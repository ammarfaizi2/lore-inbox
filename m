Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265396AbTBPASe>; Sat, 15 Feb 2003 19:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265423AbTBPASe>; Sat, 15 Feb 2003 19:18:34 -0500
Received: from packet.digeo.com ([12.110.80.53]:60340 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265396AbTBPASd>;
	Sat, 15 Feb 2003 19:18:33 -0500
Date: Sat, 15 Feb 2003 16:29:04 -0800
From: Andrew Morton <akpm@digeo.com>
To: "James H. Cloos Jr." <cloos@jhcloos.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.61-mm1
Message-Id: <20030215162904.6ba8fdc2.akpm@digeo.com>
In-Reply-To: <m365rlf5ia.fsf@lugabout.jhcloos.org>
References: <20030214231356.59e2ef51.akpm@digeo.com>
	<m365rlf5ia.fsf@lugabout.jhcloos.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Feb 2003 00:28:23.0639 (UTC) FILETIME=[509E6E70:01C2D552]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"James H. Cloos Jr." <cloos@jhcloos.com> wrote:
>
> I just tried 2.5.61 and 2.5.61-mm1 on a dell inspiron 8100.
> 
> 2.5.61 is working OK, but -mm1 hung as soon as it tried to exec init.
> init=/bin/bash showed the same failure.
> 
> init(8) was able to print out it's first line, announcing its version
> but then stopped.  with init=/bin/bash bash did not output anything.
> 

If you are using devfs then yes, there is a locking problem.

If you are not using devfs then please send me your .config.

Thanks.
