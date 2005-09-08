Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbVIHEAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbVIHEAr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 00:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbVIHEAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 00:00:47 -0400
Received: from cantor2.suse.de ([195.135.220.15]:11468 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751223AbVIHEAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 00:00:46 -0400
From: Andi Kleen <ak@suse.de>
To: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: 2.6.13-mm1 X86_64: All 32bit programs segfault
Date: Thu, 8 Sep 2005 06:00:38 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <431FB5FF.1030700@comcast.net>
In-Reply-To: <431FB5FF.1030700@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509080600.39368.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 September 2005 05:54, Parag Warudkar wrote:
> I am clueless as to what's going on but just raising a flag in case it
> is a not yet known problem.
> Thunderbird, 32bit Sun Java and Opera are the ones I tried. They all
> work fine with the Fedora 2.6.12-x kernel but
> consistently seg fault with 2.6.13-mm1.

Hmm - not many x86-64 patches in mm1. 2.6.13 definitely works.

>
> Parag
> --------
> Sample stack trace for java -
> gdb ./java

Last lines of strace -f + the kernel message from dmesg might be useful.

-Andi
