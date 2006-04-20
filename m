Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWDTKBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWDTKBA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 06:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWDTKBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 06:01:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4764 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750810AbWDTKA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 06:00:59 -0400
Date: Thu, 20 Apr 2006 02:59:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: torvalds@osdl.org, agk@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] Device-mapper snapshot metadata userspace breakage
Message-Id: <20060420025953.577e2225.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0604201159350.29821@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0604201159350.29821@sbz-30.cs.Helsinki.FI>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
>
> The commit aa14edeb994f8f7e223d02ad14780bf2fa719f6d "[PATCH] device-mapper 
>  snapshot: load metadata on creation" breaks userspace and is blocking us 
>  from moving to the 2.6.16 series kernel. Debian doesn't have the 
>  new required LVM version in stable yet. Is the change intentional?

The changelog said

  If you're using lvm2, for this patch to work properly you should update
  to lvm2 version 2.02.01 or later and device-mapper version 1.02.02 or
  later.

Which was pretty bad of us.  I hope LVM 2.02.01 userspace is
back-compatible with older kernels?
