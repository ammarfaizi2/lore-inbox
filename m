Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267920AbTBVVot>; Sat, 22 Feb 2003 16:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267927AbTBVVot>; Sat, 22 Feb 2003 16:44:49 -0500
Received: from packet.digeo.com ([12.110.80.53]:13232 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267920AbTBVVos>;
	Sat, 22 Feb 2003 16:44:48 -0500
Date: Sat, 22 Feb 2003 13:55:07 -0800
From: Andrew Morton <akpm@digeo.com>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: procps-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] procfs/procps threading performance speedup, 2.5.62
Message-Id: <20030222135507.5f539bba.akpm@digeo.com>
In-Reply-To: <1045947170.19445.57.camel@cube>
References: <Pine.LNX.4.44.0302201818060.32324-100000@localhost.localdomain>
	<1045947170.19445.57.camel@cube>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Feb 2003 21:54:51.0558 (UTC) FILETIME=[06AEAC60:01C2DABD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan <albert@users.sourceforge.net> wrote:
>
> Note that the recent /proc/*/wchan addition was botched.
> Caching is prevented due to race conditions. This could
> be fixed by changing the file format to contain:
>     number, function name

There is not enough detail here for it to be fixed.

What are the race conditions?

What is "number"?

