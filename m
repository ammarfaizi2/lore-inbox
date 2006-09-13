Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbWIMSQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbWIMSQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 14:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWIMSQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 14:16:58 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:21638 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751023AbWIMSQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 14:16:57 -0400
Date: Wed, 13 Sep 2006 11:16:49 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: David Howells <dhowells@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Dong Feng <middle.fengdong@gmail.com>, ak@suse.de,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: Why Semaphore Hardware-Dependent?
In-Reply-To: <45084A2C.8030804@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0609131113550.18264@schroedinger.engr.sgi.com>
References: <44F395DE.10804@yahoo.com.au>  <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com>
 <1156750249.3034.155.camel@laptopd505.fenrus.org> <11861.1156845927@warthog.cambridge.redhat.com>
 <45084833.4040602@yahoo.com.au> <Pine.LNX.4.64.0609131106260.18264@schroedinger.engr.sgi.com>
 <45084A2C.8030804@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2006, Nick Piggin wrote:

> Oh really? OK I figured if ppc64 was OK then that would be enough,
> but your large Altix systems did slip my mind.

Look at the ia64 rwsem implementation in include/asm-ia64/rwsem.h.
 
> That is a fair criticism... atomic_long it will have to be, then.
> That will require a bit of atomic work to get atomic64_cmpxchg
> available on all 64-bit architectures.

I would greatly appreciate having that.

