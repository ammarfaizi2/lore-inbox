Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265461AbUBFNuY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 08:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265468AbUBFNuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 08:50:23 -0500
Received: from almesberger.net ([63.105.73.238]:14602 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S265461AbUBFNuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 08:50:18 -0500
Date: Fri, 6 Feb 2004 10:50:09 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Matt <dirtbird@ntlworld.com>, linux-kernel@vger.kernel.org
Subject: Re: VFS locking: f_pos thread-safe ?
Message-ID: <20040206105008.B18820@almesberger.net>
References: <402359E1.6000007@ntlworld.com> <20040206011630.42ed5de1.akpm@osdl.org> <40235DCC.2060606@ntlworld.com> <20040206013523.394d89f1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040206013523.394d89f1.akpm@osdl.org>; from akpm@osdl.org on Fri, Feb 06, 2004 at 01:35:23AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Not unless we can think of a way in which it actually matters, thanks.

What I'm struggling with when reading that POSIX draft is to
understand whether CLONE_FILES is appropriate or not for
pthread_create.

If this is unspecified, the f_pos issue becomes largely academic,
although one might argue that read() should behave either one
way or the other.

And no, luckily, I don't have a real-life application for this
either :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
