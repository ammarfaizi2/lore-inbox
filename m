Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129041AbQJ3Jqj>; Mon, 30 Oct 2000 04:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129100AbQJ3Jq3>; Mon, 30 Oct 2000 04:46:29 -0500
Received: from chiara.elte.hu ([157.181.150.200]:47622 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129041AbQJ3JqS>;
	Mon, 30 Oct 2000 04:46:18 -0500
Date: Mon, 30 Oct 2000 11:56:06 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <20001030023339.A20102@vger.timpanogas.org>
Message-ID: <Pine.LNX.4.21.0010301155120.3186-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Oct 2000, Jeff V. Merkey wrote:

> > reads dominate writes in almost all workloads, thats common wisdom. Why
> > write if nobody reads the data? And while web servers are mostly read only
> > data, they can write data as well, see POST and PUT. The fact that
> > incoming writes are hard should not let you distract from the fact that
> > reads are also extremely important.
>
> Web servers don't do writes, unless a CGI script is running somewhere
> or some Java or Perl or something, then this stuff goes through a
> wrapper, which is slow, or did I miss something.

yes, you missed TUX modules.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
