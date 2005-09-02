Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030647AbVIBCGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030647AbVIBCGi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 22:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030646AbVIBCGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 22:06:38 -0400
Received: from mail.suse.de ([195.135.220.2]:50375 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030641AbVIBCGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 22:06:37 -0400
From: Andi Kleen <ak@suse.de>
To: Hiro Yoshioka <hyoshiok@miraclelinux.com>
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
Date: Fri, 2 Sep 2005 04:06:31 +0200
User-Agent: KMail/1.8
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <20050825.135420.640917643.hyoshiok@miraclelinux.com> <200509011136.38057.ak@suse.de> <20050902.104359.26944961.hyoshiok@miraclelinux.com>
In-Reply-To: <20050902.104359.26944961.hyoshiok@miraclelinux.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509020406.32323.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 September 2005 03:43, Hiro Yoshioka wrote:
> From: Andi Kleen <ak@suse.de>
>
> > On Thursday 01 September 2005 11:07, Hiro Yoshioka wrote:
> > > The following is the almost final version of the
> > > cache pollution aware __copy_from_user_ll() patch.
> >
> > Looks good to me.
> >
> > Once the filemap.c hunk is in I'll probably do something
> > similar for x86-64.
>
> Thank you very much. What else should I do? Shall I just
> be waiting to check in the patch?

I suppose Andrew will take care of it, unless someone else
objects.

-Andi
