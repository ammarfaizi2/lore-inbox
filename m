Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261647AbSJFPai>; Sun, 6 Oct 2002 11:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261648AbSJFPah>; Sun, 6 Oct 2002 11:30:37 -0400
Received: from mail.zedat.fu-berlin.de ([130.133.1.48]:34729 "EHLO
	Mail.ZEDAT.FU-Berlin.DE") by vger.kernel.org with ESMTP
	id <S261647AbSJFPah>; Sun, 6 Oct 2002 11:30:37 -0400
Message-Id: <m17yDRu-006i0MC@Mail.ZEDAT.FU-Berlin.DE>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>,
       Rob Landley <landley@trommello.org>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - (NUMA))
Date: Sun, 6 Oct 2002 17:14:31 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
References: <m17yCIx-006hSwC@Mail.ZEDAT.FU-Berlin.DE> <1281002684.1033892373@[10.10.2.3]>
In-Reply-To: <1281002684.1033892373@[10.10.2.3]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 October 2002 17:19, Martin J. Bligh wrote:
> > Then there's the issue of application startup. There's not enough
> > read ahead. This is especially sad, as the order of page faults is
> > at least partially predictable.
>
> Is the problem really, fundamentally a lack of readahead in the
> kernel? Or is it that your application is huge bloated pig?
> With admittedly no evidence whatsoever, I suspect the latter is
> really the root cause of this type of problem.

Of course, but that's not an excuse for sucking more than necessary.
Application startup is a problem.

	Regards
		Oliver
