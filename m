Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbWEWExD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWEWExD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 00:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWEWExD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 00:53:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:5772 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751029AbWEWExC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 00:53:02 -0400
From: Andi Kleen <ak@suse.de>
To: Brian Gerst <bgerst@didntduck.org>
Subject: Re: [stable][patch] x86_64: fix number of ia32 syscalls
Date: Tue, 23 May 2006 04:50:16 +0200
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>
References: <200605221701_MC3-1-C081-B4B3@compuserve.com> <200605230111.18121.ak@suse.de> <447249C5.6060706@didntduck.org>
In-Reply-To: <447249C5.6060706@didntduck.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605230450.17081.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 May 2006 01:31, Brian Gerst wrote:
> Andi Kleen wrote:
> > On Monday 22 May 2006 22:59, Chuck Ebbert wrote:
> >> Recent discussions about whether to print a message about unimplemented
> >> ia32 syscalls on x86_64 have missed the real bug: the number of ia32
> >> syscalls is wrong in 2.6.16.  Fixing that kills the message.
> > 
> > There is already a slightly different patch for this in the FF tree.
> > 
> 
> Where is the FF tree?

ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/

-Andi
