Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbWCHTFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWCHTFv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 14:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWCHTFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 14:05:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:8615 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932506AbWCHTFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 14:05:50 -0500
From: Andi Kleen <ak@suse.de>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
Date: Wed, 8 Mar 2006 12:38:38 +0100
User-Agent: KMail/1.9.1
Cc: Alan Cox <alan@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
References: <20060308184500.GA17716@devserv.devel.redhat.com> <11922.1141842907@warthog.cambridge.redhat.com> <14067.1141844393@warthog.cambridge.redhat.com>
In-Reply-To: <14067.1141844393@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200603081238.39372.ak@suse.de>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 March 2006 19:59, David Howells wrote:
> Alan Cox <alan@redhat.com> wrote:
> 
> > then on some NUMA infrastructures the order may not be as you expect.
> 
> Oh, yuck!
> 
> Okay... does NUMA guarantee the same for ordinary memory accesses inside the
> critical section?


If you use barriers the ordering should be the same on cc/NUMA vs SMP.
Otherwise it wouldn't be "cc" 

But it might be quite unfair.

-Andi

