Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265121AbUFVTdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265121AbUFVTdy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 15:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265663AbUFVTdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 15:33:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:31652 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265517AbUFVTYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 15:24:01 -0400
Date: Tue, 22 Jun 2004 12:22:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: mikpe@csd.uu.se, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: core
Message-Id: <20040622122254.10bf8ff7.akpm@osdl.org>
In-Reply-To: <16600.15183.989137.233305@alkaid.it.uu.se>
References: <200405312218.i4VMIISg012277@harpo.it.uu.se>
	<20040622015311.561a73bf.akpm@osdl.org>
	<16600.15183.989137.233305@alkaid.it.uu.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> wrote:
>
>  > We need (especially at this stage in the kernel cycle) at least a couple of
>   > pages of design documentation which describes
> 
>  Speaking of documentation, I have a strong preference for using
>  LaTeX for all papers, reports, docs, etc, except man pages.
>  Is that an acceptable format?

Sounds fine, but excessive for this exercise.  At this stage I'm asking for
sufficient description of the kernel patch to allow other developers to
understand and review the patch, maybe hack on it a bit.  A couple of pages
of ascii should suffice.  I'd consider it compulsory for patches of this
magnitude and scope.

Longer term, yes - having added a bunch of new syscalls to the kernel we
have a responsibility to document the user/kernel API for downstream users,
but that's not a requirement for reviewing the patch.
