Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263784AbUEMFsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbUEMFsW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 01:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbUEMFsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 01:48:22 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:50446 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263784AbUEMFsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 01:48:21 -0400
Date: Thu, 13 May 2004 06:48:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: Andrew Morton <akpm@osdl.org>, davidm@hpl.hp.com, rddunlap@osdl.org,
       ebiederm@xmission.com, drepper@redhat.com, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: [announce] kexec for linux 2.6.6
Message-ID: <20040513064813.A5777@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Willy Tarreau <willy@w.ods.org>, Andrew Morton <akpm@osdl.org>,
	davidm@hpl.hp.com, rddunlap@osdl.org, ebiederm@xmission.com,
	drepper@redhat.com, fastboot@lists.osdl.org,
	linux-kernel@vger.kernel.org
References: <m1brktod3f.fsf@ebiederm.dsl.xmission.com> <40A2517C.4040903@redhat.com> <m17jvhoa6g.fsf@ebiederm.dsl.xmission.com> <20040512143233.0ee0405a.rddunlap@osdl.org> <16546.41076.572371.307153@napali.hpl.hp.com> <20040512152815.76280eac.akpm@osdl.org> <16546.42537.765495.231960@napali.hpl.hp.com> <20040512161603.44c50cec.akpm@osdl.org> <20040513053051.A5286@infradead.org> <20040513050515.GA578@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040513050515.GA578@alpha.home.local>; from willy@w.ods.org on Thu, May 13, 2004 at 07:05:15AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 07:05:15AM +0200, Willy Tarreau wrote:
> And why not definitely assign sort of a "multiplexed syscall" entry,
> a la sys_socketcall() ?

Because that's the worst possible API you could imagine.

