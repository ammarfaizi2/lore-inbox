Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262574AbSJGS7u>; Mon, 7 Oct 2002 14:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262588AbSJGS7u>; Mon, 7 Oct 2002 14:59:50 -0400
Received: from dsl-213-023-021-129.arcor-ip.net ([213.23.21.129]:19115 "EHLO
	starship") by vger.kernel.org with ESMTP id <S262574AbSJGS7r>;
	Mon, 7 Oct 2002 14:59:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 -  (NUMA))
Date: Mon, 7 Oct 2002 21:05:16 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Oliver Neukum <oliver@neukum.name>,
       Rob Landley <landley@trommello.org>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
References: <m17yCIx-006hSwC@Mail.ZEDAT.FU-Berlin.DE> <E17ybuZ-0003tz-00@starship> <3DA1D30E.B3255E7D@digeo.com>
In-Reply-To: <3DA1D30E.B3255E7D@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17ydBs-0003uE-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 October 2002 20:31, Andrew Morton wrote:
> Daniel Phillips wrote:
> > [1] We could teach each filesystem how to read ahead across directories, or
> > we could teach the vfs how to do physical readahead.  Choose your poison.
> 
> Devices do physical readahead, and it works nicely.

Devices have a few MB of readahead cache, the kernel can have thousands of
times as much.

-- 
Daniel
