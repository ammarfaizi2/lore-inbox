Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbUEMFb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUEMFb4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 01:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbUEMFbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 01:31:55 -0400
Received: from holomorphy.com ([207.189.100.168]:59835 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261422AbUEMFbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 01:31:55 -0400
Date: Wed, 12 May 2004 22:21:37 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       davidm@hpl.hp.com, rddunlap@osdl.org, ebiederm@xmission.com,
       drepper@redhat.com, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: [announce] kexec for linux 2.6.6
Message-ID: <20040513052137.GM1397@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Willy Tarreau <willy@w.ods.org>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, davidm@hpl.hp.com, rddunlap@osdl.org,
	ebiederm@xmission.com, drepper@redhat.com, fastboot@lists.osdl.org,
	linux-kernel@vger.kernel.org
References: <m1brktod3f.fsf@ebiederm.dsl.xmission.com> <40A2517C.4040903@redhat.com> <m17jvhoa6g.fsf@ebiederm.dsl.xmission.com> <20040512143233.0ee0405a.rddunlap@osdl.org> <16546.41076.572371.307153@napali.hpl.hp.com> <20040512152815.76280eac.akpm@osdl.org> <16546.42537.765495.231960@napali.hpl.hp.com> <20040512161603.44c50cec.akpm@osdl.org> <20040513053051.A5286@infradead.org> <20040513050515.GA578@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040513050515.GA578@alpha.home.local>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 07:05:15AM +0200, Willy Tarreau wrote:
> And why not definitely assign sort of a "multiplexed syscall" entry,
> a la sys_socketcall() ? It could be shared by lots of non-mainline projects
> and have a greater chance of being stable along the time.

That already exists and is every bit as hated as it should be.
It's called ioctl().


-- wli
