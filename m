Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263885AbUEMHit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263885AbUEMHit (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 03:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263904AbUEMHit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 03:38:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:12457 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263885AbUEMHis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 03:38:48 -0400
Date: Thu, 13 May 2004 00:37:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: ebiederm@xmission.com, rddunlap@osdl.org, davidm@hpl.hp.com,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       drepper@redhat.com
Subject: Re: [Fastboot] Re: [announce] kexec for linux 2.6.6
Message-Id: <20040513003727.4026699a.akpm@osdl.org>
In-Reply-To: <20040513083306.A6631@infradead.org>
References: <m1brktod3f.fsf@ebiederm.dsl.xmission.com>
	<40A2517C.4040903@redhat.com>
	<m17jvhoa6g.fsf@ebiederm.dsl.xmission.com>
	<20040512143233.0ee0405a.rddunlap@osdl.org>
	<16546.41076.572371.307153@napali.hpl.hp.com>
	<20040512152815.76280eac.akpm@osdl.org>
	<16546.42537.765495.231960@napali.hpl.hp.com>
	<20040512161603.44c50cec.akpm@osdl.org>
	<20040513053051.A5286@infradead.org>
	<m1lljwsvxr.fsf@ebiederm.dsl.xmission.com>
	<20040513083306.A6631@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, May 13, 2004 at 12:06:08AM -0600, Eric W. Biederman wrote:
> > So if kexec could actually get a reserved system call number that
> > would be the best solution I have seen in this thread.
> 
> Could you please show the syscall we should reserve, e.g. it's API.
> We had quite some histroy of syscalls that got reserved and the real
> submission was rejected neverless because the API was broken.

The (old) kexec patch I have here implements the API which is described at
http://lwn.net/Articles/15468/.  I doubt if it changed?
