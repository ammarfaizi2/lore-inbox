Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261642AbTCGPyz>; Fri, 7 Mar 2003 10:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261643AbTCGPyz>; Fri, 7 Mar 2003 10:54:55 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30728 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261642AbTCGPyz>; Fri, 7 Mar 2003 10:54:55 -0500
Date: Fri, 7 Mar 2003 07:49:55 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: Arun Prasad <arun@netlab.hcltech.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.51 CRC32 undefined
In-Reply-To: <1047040816.32200.59.camel@passion.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.44.0303070749160.2876-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 7 Mar 2003, David Woodhouse wrote:
> 
> Set CONFIG_CRC32=m. We probably shouldn't allow it to be set to 'Y' in
> the first place., given the above.

I don't want to have configs like this. I personally refuse to load 
modules into my kernel, and as such a subsystem that only works as a 
module is _evil_.

		Linus

