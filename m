Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbUBVQNN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 11:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUBVQLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 11:11:51 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:7333 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261688AbUBVQLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 11:11:36 -0500
Date: Sun, 22 Feb 2004 10:53:31 -0500
From: Ben Collins <bcollins@debian.org>
To: kai.engert@gmx.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: only ieee1394 from 2.4.20 works for me
Message-ID: <20040222155331.GG7858@phunnypharm.org>
References: <4038BDC3.9030304@kuix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4038BDC3.9030304@kuix.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 22, 2004 at 03:33:39PM +0100, Kai Engert wrote:
> In the last year I have been playing with a variety of combinations of 
> ieee1394 controllers, machines, external mass storage devices and linux 
> kernel versions. So have some friends of mine.
> 
> The only version that works for us is the ieee1394 code that was 
> included with kernel version 2.4.20.
> 
> (I removed drivers/ieee1394 completely, and replaced it with 
> drivers/ieee1394 from 2.4.20)
> 
> Using that snapshot, we are able to transfer data to disks and video 
> from a camcorder just fine, in all combinations we have tested.
> 
> Every other kernel version, both older or newer than 2.4.20, is broken. 
> We either see random errors, or writing data to disks stalls 
> immediately, or daisy chained devices don't work.
> 
> I'm currently using the official Fedora core 1 series kernels, patched 
> that way, and it works like a charm.
> 
> Please consider to use the 2.4.20 ieee1394 snapshot in future 2.4.x 
> releases.

It's pretty strange that I haven't heard of such problems. Maybe you
would consider trying to debug the problem rather than reverting to
source that is several years old (and that I know is broken).

Latest 2.4.x code (that which is in our SVN repo) works fine for me.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
