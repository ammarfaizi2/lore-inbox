Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbWGMK6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbWGMK6g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 06:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWGMK6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 06:58:35 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:6587 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751470AbWGMK6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 06:58:34 -0400
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Jakub Jelinek <jakub@redhat.com>, Ulrich Drepper <drepper@redhat.com>,
       Roland McGrath <roland@redhat.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
In-Reply-To: <44B58396.7080703@zytor.com>
References: <20060712184412.2BD57180061@magilla.sf.frob.com>
	 <44B54EA4.5060506@redhat.com> <20060712195349.GW3823@sunsite.mff.cuni.cz>
	 <44B556E5.5000702@zytor.com> <m1k66i8ql5.fsf@ebiederm.dsl.xmission.com>
	 <1152739766.3217.83.camel@laptopd505.fenrus.org>
	 <m1bqru8p36.fsf@ebiederm.dsl.xmission.com>
	 <1152741665.3217.85.camel@laptopd505.fenrus.org>
	 <44B57191.5000802@zytor.com>  <m1zmfe794e.fsf@ebiederm.dsl.xmission.com>
	 <1152745664.22943.115.camel@localhost.localdomain>
	 <44B58396.7080703@zytor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 13 Jul 2006 12:15:59 +0100
Message-Id: <1152789359.5511.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-07-12 am 16:19 -0700, ysgrifennodd H. Peter Anvin:
> glibc is (and has to be) LGPL.
> 
> Anyway, it seems absolutely insane that having a programmable threshold 
> for spinning is patented...

I'm not aware programmable thresholds are patented/patent-pending, just
having the kernel indicate through a shared variable whether other tasks
are waiting so that it avoids syscalls and latency costs.

