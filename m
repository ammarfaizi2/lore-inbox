Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269495AbUJGGYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269495AbUJGGYI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 02:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269657AbUJGGYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 02:24:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:34498 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269495AbUJGGYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 02:24:06 -0400
Date: Wed, 6 Oct 2004 23:22:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: serue@us.ibm.com, chrisw@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/3] lsm: add bsdjail module
Message-Id: <20041006232208.505ccacd.akpm@osdl.org>
In-Reply-To: <Xine.LNX.4.44.0410070216130.2191-100000@thoron.boston.redhat.com>
References: <20041007040859.GA17774@escher.cs.wm.edu>
	<Xine.LNX.4.44.0410070216130.2191-100000@thoron.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@redhat.com> wrote:
>
> On Thu, 7 Oct 2004, Serge E. Hallyn wrote:
> 
>  > Because it gives Linux a functionality like FreeBSD's jail and Solaris'
>  > zones in an unobtrusive manner, without impacting users who don't wish
>  > to use it  (except for the extra security_task_lookup function calls).
> 
>  Yes, as an LSM module, it can be configured out.  I think it's a good use
>  of the LSM framework, and may be useful for people migrating to Linux from
>  legacy Solaris and FreeBSD.

Sure, but that's a bit speculative for adding a feature to the mainline
kernel.

Is there vendor pull for this feature?  Do IBM have customers requiring it?

"someone might like this" is not a sufficient basis for adding stuff to the
kernel, sorry.
