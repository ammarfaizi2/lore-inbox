Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbVJIQ4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbVJIQ4u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 12:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbVJIQ4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 12:56:50 -0400
Received: from ns.suse.de ([195.135.220.2]:32647 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932122AbVJIQ4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 12:56:49 -0400
From: Andi Kleen <ak@suse.de>
To: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Subject: Re: [PATCH] i386: fix stack alignment for signal handlers
Date: Sun, 9 Oct 2005 18:57:11 +0200
User-Agent: KMail/1.8.2
Cc: Linus Torvalds <torvalds@osdl.org>, Daniel Jacobowitz <dan@debian.org>,
       linux-kernel@vger.kernel.org
References: <43273CB3.7090200@oberhumer.com> <20050914154425.GM11338@wotan.suse.de> <43494B3F.5070303@oberhumer.com>
In-Reply-To: <43494B3F.5070303@oberhumer.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510091857.11566.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 October 2005 18:54, Markus F.X.J. Oberhumer wrote:

> Here is a somewhat simplified version of my previous patch with
> updated comments.
>
> Attached is also a new small user-space test program which does not
> depend on any special gcc features and should trigger the problem on all
> machines.

I already have a version of the patch in my queue, but it's not a strict 
bugfix so it's only for after 2.6.14.

-Andi

ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt-current/patches/sigframe-alignment


