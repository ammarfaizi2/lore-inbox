Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbULMRHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbULMRHl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 12:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbULMRHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 12:07:41 -0500
Received: from mail.kroah.org ([69.55.234.183]:37056 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261303AbULMRHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 12:07:17 -0500
Date: Mon, 13 Dec 2004 08:06:49 -0800
From: Greg KH <greg@kroah.com>
To: "J.A. Magallon" <jamagallon@able.es>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3-mm1
Message-ID: <20041213160649.GA11397@kroah.com>
References: <20041213020319.661b1ad9.akpm@osdl.org> <1102950109l.7596l.0l@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102950109l.7596l.0l@werewolf.able.es>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 03:01:49PM +0000, J.A. Magallon wrote:
> 
> On 2004.12.13, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc3/2.6.10-rc3-mm1/
> > 
> 
> I remember that people agreed that this should not be _GPL:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109935991217693&w=2
> 
> --- linux-2.6.10-rc2-jam2/drivers/base/class_simple.c.orig	2004-11-21 23:47:05.000000000 +0100
> +++ linux-2.6.10-rc2-jam2/drivers/base/class_simple.c	2004-11-21 23:47:46.000000000 +0100

It's there due to the way bk works.  I just rebuilt my driver-2.6 tree a
while ago, and Andrew had these changesets in his tree.  Then he pulled
again, and these changes stayed in his local tree.

So, to fix this, Andrew needs to blow away his driver-2.6 tree and clone
it again.  Not too tough :)

thanks,

greg k-h
