Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965042AbWH2P5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbWH2P5M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 11:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbWH2P5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 11:57:12 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:13448 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965042AbWH2P5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 11:57:10 -0400
Date: Tue, 29 Aug 2006 08:56:36 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: David Howells <dhowells@redhat.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Dong Feng <middle.fengdong@gmail.com>, ak@suse.de,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: Why Semaphore Hardware-Dependent? 
In-Reply-To: <11861.1156845927@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0608290855510.18031@schroedinger.engr.sgi.com>
References: <44F395DE.10804@yahoo.com.au>  <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com>
 <1156750249.3034.155.camel@laptopd505.fenrus.org> 
 <11861.1156845927@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2006, David Howells wrote:

> Because i386 (and x86_64) can do better by using XADDL/XADDQ.

And Ia64 would like to use fetchadd....

> CMPXCHG is not available on all archs, and may not be implemented on all archs
> through other atomic instructions.

Which arches do not support cmpxchg?
 
