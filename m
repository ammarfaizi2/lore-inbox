Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUCaADX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 19:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbUCaADX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 19:03:23 -0500
Received: from mail.kroah.org ([65.200.24.183]:53193 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262138AbUCaADW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 19:03:22 -0500
Date: Tue, 30 Mar 2004 16:03:01 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc3-mm1
Message-ID: <20040331000301.GB9269@kroah.com>
References: <20040330023437.72bb5192.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330023437.72bb5192.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 02:34:37AM -0800, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc3/2.6.5-rc3-mm1/
> 
> - Dropped the tty locking fix.  As predicted, it deadlocked.  I also
>   reverted the patch from bk-driver-core.patch which is causing this race to
>   trigger more frequently.

Argh, so the only way I'm going to be able to get my little, tiny,
simple vc class patch is by fixing all of the tty layer locking code?

Ugh, that's so mean...  :)

greg k-h
