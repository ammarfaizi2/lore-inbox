Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265535AbUBFUJY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 15:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265471AbUBFUJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 15:09:24 -0500
Received: from almesberger.net ([63.105.73.238]:34571 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S265535AbUBFUJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 15:09:23 -0500
Date: Fri, 6 Feb 2004 17:09:17 -0300
From: Werner Almesberger <wa@almesberger.net>
To: linux-kernel@vger.kernel.org
Subject: Re: VFS locking: f_pos thread-safe ?
Message-ID: <20040206170917.E18820@almesberger.net>
References: <20040206041223.A18820@almesberger.net> <20040206183746.GR4902@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040206183746.GR4902@ca-server1.us.oracle.com>; from Joel.Becker@oracle.com on Fri, Feb 06, 2004 at 10:37:46AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker wrote:
> 	This reads:  "all of the specified effects of the other call,
> or none of them."
[...]
> 	Of course, that doesn't change the possible race updating
> f_pos at the end of each thread's call.

Hmm, "all, but the f_pos read-modify-write" sounds more like how
an insurance company would define "all" :-)

What's puzzling here is that the standard would introduce such an
important concept in the discussion of threads.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
