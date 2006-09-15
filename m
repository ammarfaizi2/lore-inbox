Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWIOJAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWIOJAI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 05:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWIOJAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 05:00:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7125 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750704AbWIOJAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 05:00:05 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <450974F2.1020104@yahoo.com.au> 
References: <450974F2.1020104@yahoo.com.au>  <45085B31.3080504@yahoo.com.au> <45084833.4040602@yahoo.com.au> <44F395DE.10804@yahoo.com.au> <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com> <1156750249.3034.155.camel@laptopd505.fenrus.org> <11861.1156845927@warthog.cambridge.redhat.com> <22461.1158173455@warthog.cambridge.redhat.com> <21102.1158234082@warthog.cambridge.redhat.com> 
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: David Howells <dhowells@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Dong Feng <middle.fengdong@gmail.com>, ak@suse.de,
       Paul Mackerras <paulus@samba.org>, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: Why Semaphore Hardware-Dependent? 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 15 Sep 2006 09:59:44 +0100
Message-ID: <30414.1158310784@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> It is actually larger here.
> 
>    text    data     bss     dec     hex filename
>     970       0       0     970     3ca lib/rwsem-spinlock.o
>     576       0       0     576     240 kernel/spinlock.o
>   =1546
> 
>    text    data     bss     dec     hex filename
>    1310       0       0    1310     51e lib/rwsem.o
>     193       0       0     193      c1 kernel/rwsem.o
>   =1503

What arch? FRV?

David
