Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbRE2VG4>; Tue, 29 May 2001 17:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261913AbRE2VGq>; Tue, 29 May 2001 17:06:46 -0400
Received: from twinlark.arctic.org ([204.107.140.52]:25875 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S261894AbRE2VGh>; Tue, 29 May 2001 17:06:37 -0400
Date: Tue, 29 May 2001 14:06:36 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: John Chris Wren <jcwren@jcwren.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: select() - Linux vs. BSD
In-Reply-To: <NDBBKBJHGFJMEMHPOPEGKEIICHAA.jcwren@jcwren.com>
Message-ID: <Pine.LNX.4.33.0105291404080.23425-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2001, John Chris Wren wrote:

> 	In BSD, select() states that when a time out occurs, the bits passed to
> select will not be altered.

from the single unix standard:

	On failure, the objects pointed to by the readfds, writefds,
	and errorfds arguments are not modified. If the timeout interval
	expires without the specified condition being true for any of
	the specified file descriptors, the objects pointed to by the
	readfds, writefds, and errorfds arguments have all bits set to 0.

> 	Should the man pages be changed to reflect reality, or select() fixed to
> act like BSD?

sounds like a man page bug.

-dean

