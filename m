Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277807AbRJRRFw>; Thu, 18 Oct 2001 13:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277808AbRJRRFn>; Thu, 18 Oct 2001 13:05:43 -0400
Received: from peace.netnation.com ([204.174.223.2]:36365 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S277807AbRJRRF1>; Thu, 18 Oct 2001 13:05:27 -0400
Date: Thu, 18 Oct 2001 10:05:56 -0700
From: Simon Kirby <sim@netnation.com>
To: "David S. Miller" <davem@redhat.com>
Cc: andi@firstfloor.org, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: Awfully slow /proc/net/tcp, netstat, in.identd in 2.4 (updated)
Message-ID: <20011018100556.A4814@netnation.com>
In-Reply-To: <20011018094222.A31919@netnation.com> <20011018.094956.107683652.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20011018.094956.107683652.davem@redhat.com>; from davem@redhat.com on Thu, Oct 18, 2001 at 09:49:56AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2001 at 09:49:56AM -0700, David S. Miller wrote:

> Let me guess, the machine exhibiting the problem has the largest
> amount of physical memory?

You're right.  I was wrong about the identical hardware -- somebody has
recently added another 128 MB to the box, and so it has 640 MB in there
at the moment.  Most other boxes are 512 MB, and that other inactive
server was only 128 MB.  Ah, the one I was comparing it with was only 384
MB, even.  So yeah, it's probably memory-size related.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
