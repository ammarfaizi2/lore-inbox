Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312942AbSDSVNW>; Fri, 19 Apr 2002 17:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312988AbSDSVNV>; Fri, 19 Apr 2002 17:13:21 -0400
Received: from air-2.osdl.org ([65.201.151.6]:60167 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S312942AbSDSVNV>;
	Fri, 19 Apr 2002 17:13:21 -0400
Date: Fri, 19 Apr 2002 14:09:14 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Ben Greear <greearb@candelatech.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: unresolved symbol: __udivdi3
In-Reply-To: <3CC08632.8020102@candelatech.com>
Message-ID: <Pine.LNX.4.33L2.0204191408450.15597-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2002, Ben Greear wrote:

| I would like to be able to devide 64bit numbers in a kernel module,
| but I get unresolved symbols when trying to insmod.
|
| Does anyone have any ideas how to get around this little issue
| (without the obvious of casting the hell out of all my __u64s
| when doing division and throwing away precision.)?

Did you look at linux/include/asm*/div64.h ?

-- 
~Randy

