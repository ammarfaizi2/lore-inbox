Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262010AbTCLWJm>; Wed, 12 Mar 2003 17:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262027AbTCLWJl>; Wed, 12 Mar 2003 17:09:41 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:65030 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262010AbTCLWJj>; Wed, 12 Mar 2003 17:09:39 -0500
Date: Wed, 12 Mar 2003 14:18:32 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Szakacsits Szabolcs <szaka@sienet.hu>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
In-Reply-To: <Pine.LNX.4.30.0303122242180.18833-100000@divine.city.tvnet.hu>
Message-ID: <Pine.LNX.4.44.0303121417530.15738-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Mar 2003, Szakacsits Szabolcs wrote:
>
> If I understand you correctly, no. We have the boundary at EIP.

Yes.

> Decoding what's before is max 7-8 tries by a human and one can figure
> out the real code from the context (with high probability).

The point being "with high probability".

I'm not adding uncertain instruction decoding to the kernel.

			Linus

