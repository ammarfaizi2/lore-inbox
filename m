Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264773AbUEOWyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264773AbUEOWyW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 18:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264768AbUEOWyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 18:54:22 -0400
Received: from mail.shareable.org ([81.29.64.88]:57225 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264775AbUEOWyV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 18:54:21 -0400
Date: Sat, 15 May 2004 23:54:01 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Al Niessner <Al.Niessner@jpl.nasa.gov>, linux-kernel@vger.kernel.org
Subject: Re: atomic_t and atomic_inc
Message-ID: <20040515225401.GA17504@mail.shareable.org>
References: <1082660320.28900.193.camel@morte.jpl.nasa.gov> <Pine.LNX.4.53.0404221641120.940@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0404221641120.940@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> Type atomic_t is an integer that can be accessed in memory
> with an uninterruptible instruction. This limits the atomic_t
> type in 32-bit machines to 32-bits, in 64-bit machines to 64-bits,
> etc. It has nothing to do with wrap-around. If you increment
> 0xffffffff it becomes 0 even it it's an atomic type.

Note that atomic_t used to be 24 bits on Sparc.  It isn't any more, though.

-- Jame
