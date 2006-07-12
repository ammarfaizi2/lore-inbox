Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbWGLWBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWGLWBS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 18:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWGLWBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 18:01:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12423 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932459AbWGLWBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 18:01:17 -0400
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
From: Arjan van de Ven <arjan@infradead.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Jakub Jelinek <jakub@redhat.com>,
       Ulrich Drepper <drepper@redhat.com>, Roland McGrath <roland@redhat.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
In-Reply-To: <m1bqru8p36.fsf@ebiederm.dsl.xmission.com>
References: <20060712184412.2BD57180061@magilla.sf.frob.com>
	 <44B54EA4.5060506@redhat.com> <20060712195349.GW3823@sunsite.mff.cuni.cz>
	 <44B556E5.5000702@zytor.com> <m1k66i8ql5.fsf@ebiederm.dsl.xmission.com>
	 <1152739766.3217.83.camel@laptopd505.fenrus.org>
	 <m1bqru8p36.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 00:01:05 +0200
Message-Id: <1152741665.3217.85.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It is a short busy wait before falling asleep.  I assume you mean
> busy wait is a loss even on SMP?

eh yeah I forgot to think for a second. But yes even for SMP busy wait
is pretty bad power wise nowadays.. at least if you wait more than a few
hundred cycles. (and if you wait less... then it's almost unlikely that
it'll be useful as well)


