Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWHVLdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWHVLdS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 07:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWHVLdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 07:33:18 -0400
Received: from mail.suse.de ([195.135.220.2]:57283 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932175AbWHVLdR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 07:33:17 -0400
Date: Tue, 22 Aug 2006 13:33:06 +0200
From: Andi Kleen <ak@suse.de>
To: Ian Campbell <Ian.Campbell@XenSource.com>
Cc: Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@XenSource.com>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Ian Pratt <ian.pratt@XenSource.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Virtualization <virtualization@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH 1 of 1] x86_43: Put .note.* sections into a PT_NOTE
 segment in vmlinux
Message-Id: <20060822133306.79fac714.ak@suse.de>
In-Reply-To: <1156245258.5091.17.camel@localhost.localdomain>
References: <2bf2abf6e97048bbef24.1154462451@ezr>
	<1156245258.5091.17.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2006 12:14:18 +0100
Ian Campbell <Ian.Campbell@XenSource.com> wrote:

> On Tue, 2006-08-01 at 13:00 -0700, Jeremy Fitzhardinge wrote:
> > This patch will pack any .note.* section into a PT_NOTE segment in the
> > output file.
> [...]
> > This only changes i386 for now, but I presume the corresponding
> > changes for other architectures will be as simple.
> 
> Here is the patch for x86_64.

Ok, but can you please resubmit with complete changelog/rationale?

Thanks,

-Andi
