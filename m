Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264267AbUACWQK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 17:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbUACWQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 17:16:10 -0500
Received: from mail.kroah.org ([65.200.24.183]:65422 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264267AbUACWQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 17:16:05 -0500
Date: Sat, 3 Jan 2004 14:08:01 -0800
From: Greg KH <greg@kroah.com>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
Message-ID: <20040103220801.GH11061@kroah.com>
References: <200401010634.28559.rob@landley.net> <Pine.LNX.4.44.0401020051590.29346-100000@gaia.cela.pl> <20040102103104.GA28168@mark.mielke.cc> <20040103060748.GF5306@kroah.com> <200401030651.i036p8mb009710@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401030651.i036p8mb009710@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 01:51:08AM -0500, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 02 Jan 2004 22:07:48 PST, Greg KH <greg@kroah.com>  said:
> 
> > What is "efficiently"?  No one really cares about milliseconds here,
> > seconds are even tollerable at least for small seconds :)
> 
> Anybody who's had to sit and watch a Sun E10K enumerate 400+ disks
> will disagree with that, unless "small seconds" are tiny fractions thereof. :)

It's "small seconds" _after_ the kernel has enumerated them.  That's the
majority of the time spent enumerating scsi disks.

Also, udev will be running while the kernel is off detecting the next
disk.

thanks,

greg k-h
