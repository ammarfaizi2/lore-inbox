Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261857AbTBYTBk>; Tue, 25 Feb 2003 14:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbTBYTBk>; Tue, 25 Feb 2003 14:01:40 -0500
Received: from packet.digeo.com ([12.110.80.53]:31404 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261857AbTBYTBj>;
	Tue, 25 Feb 2003 14:01:39 -0500
Date: Tue, 25 Feb 2003 11:12:15 -0800
From: Andrew Morton <akpm@digeo.com>
To: Cliff White <cliffw@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, dmccr@us.ibm.com,
       cliffw@osdl.org
Subject: Re: 2.5.62-mm3 -Panics during dbt2 run
Message-Id: <20030225111215.27c14ac7.akpm@digeo.com>
In-Reply-To: <200302251849.h1PInh921599@mail.osdl.org>
References: <20030225015537.4062825b.akpm@digeo.com>
	<200302251849.h1PInh921599@mail.osdl.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Feb 2003 19:11:48.0023 (UTC) FILETIME=[BE7AF470:01C2DD01]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cliff White <cliffw@osdl.org> wrote:
>
> 
> Tried hard to test this, but all it does for me is panic.
> Is this fixed in 2.5.63?
> This is 4-way PIII system. 
>  panic, while booting
> Press Y within 1 seconds to force file system integrity check...
>  [<c02409e8>] as_next_request+0x38/0x50

We have some rough edges in the anticipatory scheduler.  Please
boot with elevator=deadline for now.

