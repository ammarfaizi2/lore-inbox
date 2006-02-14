Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422642AbWBNVFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422642AbWBNVFc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 16:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422648AbWBNVFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 16:05:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:38325 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422642AbWBNVFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 16:05:31 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc3-mm1: i386 compilation broken
Date: Tue, 14 Feb 2006 22:05:07 +0100
User-Agent: KMail/1.8.2
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, bunk@stusta.de,
       linux-kernel@vger.kernel.org
References: <20060214014157.59af972f.akpm@osdl.org> <6bffcb0e0602140554j56d5a95bi@mail.gmail.com> <20060214122320.21b4459b.akpm@osdl.org>
In-Reply-To: <20060214122320.21b4459b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602142205.08307.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 February 2006 21:23, Andrew Morton wrote:

> 
> Andi like to break x86 - I think it's a market-share thing.

:)  I'll try to do 32bit builds more often.
 
> I wonder why I didn't hit that problem.

It only hits with allyesconfig or obscure configurations I think

> 
> > Andrew can you add this to hot-fixes?
> 
> Done.  I backed out the whole patch.

It would have been enough to just back out that hunk. Or if you do a resync
you'll get a fixed patch.

-Andi


 
