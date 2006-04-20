Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWDTKEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWDTKEG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 06:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWDTKEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 06:04:06 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:48274 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750806AbWDTKEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 06:04:05 -0400
Date: Thu, 20 Apr 2006 13:04:03 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Andrew Morton <akpm@osdl.org>
cc: torvalds@osdl.org, agk@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] Device-mapper snapshot metadata userspace breakage
In-Reply-To: <20060420025953.577e2225.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0604201302090.29821@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0604201159350.29821@sbz-30.cs.Helsinki.FI>
 <20060420025953.577e2225.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
> > The commit aa14edeb994f8f7e223d02ad14780bf2fa719f6d "[PATCH] device-mapper 
> >  snapshot: load metadata on creation" breaks userspace and is blocking us 
> >  from moving to the 2.6.16 series kernel. Debian doesn't have the 
> >  new required LVM version in stable yet. Is the change intentional?
 
On Thu, 20 Apr 2006, Andrew Morton wrote:
> The changelog said
> 
>   If you're using lvm2, for this patch to work properly you should update
>   to lvm2 version 2.02.01 or later and device-mapper version 1.02.02 or
>   later.
> 
> Which was pretty bad of us.  I hope LVM 2.02.01 userspace is
> back-compatible with older kernels?

Yeah, I know, but that still leaves us in an unfortunate situation as the 
2.6.16 series has security fixes that are not AFAIK in 2.6.15. Anyway, if 
the change is intentional and approved, I guess we'll just have to live 
with it. Thanks!

				Pekka
