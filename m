Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262934AbTFXSGj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 14:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbTFXSGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 14:06:30 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:42193 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262934AbTFXSGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 14:06:20 -0400
Date: Tue, 24 Jun 2003 20:20:21 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "Eble, Dan" <DanE@aiinet.com>, Linus Torvalds <torvalds@transmeta.com>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] ULL postfixes for tg3.c
Message-ID: <20030624182021.GZ3710@fs.tum.de>
References: <AD59566A9D83864F871AE2E52503064005068C@aimail.aiinet.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AD59566A9D83864F871AE2E52503064005068C@aimail.aiinet.priv>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 24, 2003 at 02:00:07PM -0400, Eble, Dan wrote:
> Q: Why not to use something even easier to read (and write), like "~0ULL" or
> better yet "UINT64_MAX" (stdint.h)?

A: This seems to be an excellent idea.

Linus, what's your opinion on adding constants like UINT64_MAX to 
kernel.h and use them where appropriate?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

