Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264313AbUBKMUl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 07:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264329AbUBKMUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 07:20:40 -0500
Received: from mail.shareable.org ([81.29.64.88]:17281 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264313AbUBKMUj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 07:20:39 -0500
Date: Wed, 11 Feb 2004 12:20:31 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Alexander Viro <viro@math.psu.edu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: open-scale-2.6.2-A0
Message-ID: <20040211122031.GC15127@mail.shareable.org>
References: <20040211115828.GA13868@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040211115828.GA13868@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i've attached an obvious scalability improvement for write()s. We in
> essence used a system-global lock for every open(WRITE) - argh!

I wonder if the "rip the second arsehole" is there for a reason.

Does this scalability improvement make any measured difference in any
conceivable application, or is it just making struct inode larger?

-- Jamie
