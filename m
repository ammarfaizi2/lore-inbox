Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932631AbVIHFoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932631AbVIHFoP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 01:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932627AbVIHFoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 01:44:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:42706 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932624AbVIHFoL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 01:44:11 -0400
From: Andi Kleen <ak@suse.de>
To: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: 2.6.13-mm1 X86_64: All 32bit programs segfault
Date: Thu, 8 Sep 2005 07:44:05 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <431FB5FF.1030700@comcast.net> <200509080600.39368.ak@suse.de> <431FC7DA.6090309@comcast.net>
In-Reply-To: <431FC7DA.6090309@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509080744.06326.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 September 2005 07:10, Parag Warudkar wrote:
> Andi Kleen wrote:
> >Hmm - not many x86-64 patches in mm1. 2.6.13 definitely works.
>
> 2.6.13-git7 works. So something in -mm has gone bad (if not x86_64, may
> be i386 or arch-independent changes?)
> It seems it has got something to do with the sys_set_tid_address as
> evident from the strace output below.

If you catch a crash in gdb and type x/i $pc what do you see?

-Andi
