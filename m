Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135551AbRAQTKt>; Wed, 17 Jan 2001 14:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135583AbRAQTKb>; Wed, 17 Jan 2001 14:10:31 -0500
Received: from chiara.elte.hu ([157.181.150.200]:24082 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S135584AbRAQTKU>;
	Wed, 17 Jan 2001 14:10:20 -0500
Date: Wed, 17 Jan 2001 20:09:48 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Micah Gorrell <angelcode@myrealbox.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Hi memory support in 2.4 not working correctly.  
In-Reply-To: <006101c080ae$1c5a7910$9b2f4189@angelw2k>
Message-ID: <Pine.LNX.4.30.0101172009090.6976-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 17 Jan 2001, Micah Gorrell wrote:

> I have a compaq 8 way server with 4 gigs of memory.  I am running 2.4.0 and
> everything works just fine (except the gig - I'm still fighting with that)
> The only strange thing that I am seeing is that I only see 3.3 gigs of
> memory instead of the full 4.  Has anyone seen this and possibly know of a
> fix?

could you run this command against your .config:

	grep -i highmem .config

what does it say?

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
