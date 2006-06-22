Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932839AbWFVH5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932839AbWFVH5n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 03:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932838AbWFVH5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 03:57:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5012 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932835AbWFVH5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 03:57:42 -0400
Date: Thu, 22 Jun 2006 00:57:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Brown, Len" <len.brown@intel.com>
Cc: michal.k.k.piotrowski@gmail.com, mingo@elte.hu, arjan@linux.intel.com,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       robert.moore@intel.com
Subject: Re: 2.6.17-mm1 - possible recursive locking detected
Message-Id: <20060622005736.1124f8b8.akpm@osdl.org>
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6CF0D03@hdsmsx411.amr.corp.intel.com>
References: <CFF307C98FEABE47A452B27C06B85BB6CF0D03@hdsmsx411.amr.corp.intel.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 03:51:51 -0400
"Brown, Len" <len.brown@intel.com> wrote:

>  
> >> The key thing here is that our recent changes in
> >> how the locks are _used_ is okay -- and I think it is.
> >
> >Well.  We don't know that.  We just know that this report of unokayness
> >wasn't right.  With Ingo's Linux-only patch we're in a 
> >position to verify
> >that the locking is probably OK.
> 
> If this were really recursive, my machine would have deadlocked
> instead of booting normally like it did, no?

yup.  If it's SMP ;)
