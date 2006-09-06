Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWIFJ3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWIFJ3N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 05:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWIFJ3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 05:29:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16308 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750732AbWIFJ3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 05:29:11 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1157507203.2222.11.camel@localhost> 
References: <1157507203.2222.11.camel@localhost>  <20060905132530.GD9173@stusta.de> <20060901015818.42767813.akpm@osdl.org> <6260.1157470557@warthog.cambridge.redhat.com> 
To: john stultz <johnstul@us.ibm.com>
Cc: David Howells <dhowells@redhat.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] FRV: do_gettimeofday() should no longer use tickadj 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 06 Sep 2006 10:27:33 +0100
Message-ID: <8430.1157534853@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz <johnstul@us.ibm.com> wrote:

> From this patch it looks like the FRV arch could be trivially converted
> to GENERIC_TIME.
> 
> Would you consider the following, totally untested patch?

It certainly looks interesting.  I'll have to study the clocksource stuff -
some FRV CPUs have an effective TSC.

David
