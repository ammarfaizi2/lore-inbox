Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265422AbUBFOYm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 09:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265465AbUBFOYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 09:24:42 -0500
Received: from almesberger.net ([63.105.73.238]:25354 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S265422AbUBFOYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 09:24:41 -0500
Date: Fri, 6 Feb 2004 11:24:36 -0300
From: Werner Almesberger <wa@almesberger.net>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andrew Morton <akpm@osdl.org>, Matt <dirtbird@ntlworld.com>,
       linux-kernel@vger.kernel.org
Subject: Re: VFS locking: f_pos thread-safe ?
Message-ID: <20040206112435.C18820@almesberger.net>
References: <402359E1.6000007@ntlworld.com> <20040206011630.42ed5de1.akpm@osdl.org> <40235DCC.2060606@ntlworld.com> <20040206013523.394d89f1.akpm@osdl.org> <20040206105008.B18820@almesberger.net> <20040206135623.GH21151@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040206135623.GH21151@parcelfarce.linux.theplanet.co.uk>; from viro@parcelfarce.linux.theplanet.co.uk on Fri, Feb 06, 2004 at 01:56:23PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
> WTF does that have to CLONE_FILES?  Whether you share descriptor table
> or get an independent copy, pointers to struct file are the same.

Err, right, of course. Sorry, I shouldn't post before the caffeine
breakfast ...

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
