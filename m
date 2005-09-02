Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030400AbVIBEl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbVIBEl5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 00:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030679AbVIBEl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 00:41:57 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:23353 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030400AbVIBEl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 00:41:56 -0400
Date: Fri, 02 Sep 2005 13:37:16 +0900 (JST)
Message-Id: <20050902.133716.610538020.hyoshiok@miraclelinux.com>
To: akpm@osdl.org
Cc: ak@suse.de, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       hyoshiok@miraclelinux.com
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
From: Hiro Yoshioka <hyoshiok@miraclelinux.com>
In-Reply-To: <20050901212929.52e2d2d6.akpm@osdl.org>
References: <20050825.135420.640917643.hyoshiok@miraclelinux.com>
	<20050901.180723.982928921.hyoshiok@miraclelinux.com>
	<20050901212929.52e2d2d6.akpm@osdl.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
> Hiro Yoshioka <hyoshiok@miraclelinux.com> wrote:
> >
> > --- linux-2.6.12.4.orig/arch/i386/lib/usercopy.c	2005-08-05 16:04:37.000000000 +0900
> >  +++ linux-2.6.12.4.nt/arch/i386/lib/usercopy.c	2005-09-01 17:09:41.000000000 +0900
> 
> Really.  Please redo and retest the patch against a current kernel.

Does it mean 2.6.13? I'll do it. 

Regards,
  Hiro
