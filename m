Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbVJWUjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbVJWUjH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 16:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbVJWUjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 16:39:07 -0400
Received: from mta9.adelphia.net ([68.168.78.199]:44537 "EHLO
	mta9.adelphia.net") by vger.kernel.org with ESMTP id S1750741AbVJWUjG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 16:39:06 -0400
Date: Sun, 23 Oct 2005 13:38:50 -0700
From: Matt Zimmerman <mdz@ubuntu.com>
To: ubuntu-devel@lists.ubuntu.com, linux-kernel@vger.kernel.org
Subject: Re: Keep initrd tasks running?
Message-ID: <20051023203850.GM10501@alcor.net>
Mail-Followup-To: ubuntu-devel@lists.ubuntu.com,
	linux-kernel@vger.kernel.org
References: <4355494C.5090707@comcast.net> <1129663759.18784.98.camel@localhost.localdomain> <4355BEF4.8000800@cfl.rr.com> <4355C9F3.40004@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4355C9F3.40004@comcast.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2005 at 12:22:11AM -0400, John Richard Moser wrote:
> Phillip Susi wrote:
> > I am confused.  I thought that once the initramfs init execs the real
> > init, the initramfs is freed.  It can't be freed if there are processes
> > that still have open files there, so that would seem to prevent any
> > processes being started in the initramfs and continuing after the real
> > system is booted.
> > 
> 
> AFAIK it's pivoted and then umounted, which frees it.  This doesn't mean
> it has to be freed..  . .

It is neither pivoted nor unmounted.

-- 
 - mdz
