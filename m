Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268035AbUHFAzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268035AbUHFAzT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 20:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268037AbUHFAzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 20:55:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:46010 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268035AbUHFAzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 20:55:12 -0400
Date: Thu, 5 Aug 2004 17:53:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RSS ulimit enforcement for 2.6.8
Message-Id: <20040805175334.47f3054b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0408052048570.8229-100000@dhcp83-102.boston.redhat.com>
References: <20040805173650.4e7a8405.akpm@osdl.org>
	<Pine.LNX.4.44.0408052048570.8229-100000@dhcp83-102.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@redhat.com> wrote:
>
> On Thu, 5 Aug 2004, Andrew Morton wrote:
> 
> > >  If the current patch isn't effective enough, we may want
> > >  to add more code.  However, we may want to try the simplest
> > >  possible approach first.
> > 
> > How do we know whether it is effective enough?  How do we define this?
> 
> Good question.  I guess our usual answer is "throw it out there
> and wait for somebody to show up with a workload that needs more".
> 
> If you want I could add a bit more code proactively, but how do
> we find out whether it's really needed ?

Good question.  What I'm groping for here is some definition of what we
actually want the feature to _do_.  Once we have that, and have suitably
argued about it, we can then go off and see if the patch actually does it.

