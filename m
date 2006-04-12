Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWDLK4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWDLK4c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 06:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWDLK4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 06:56:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63386 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932151AbWDLK4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 06:56:31 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060411150512.5dd6e83d.akpm@osdl.org> 
References: <20060411150512.5dd6e83d.akpm@osdl.org>  <16476.1144773375@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use atomic ops for file_nr accounting, not spinlock+irq 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Wed, 12 Apr 2006 11:56:17 +0100
Message-ID: <17771.1144839377@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> > Make the kernel use atomic operations for files_stat.nr_files accounting
> > rather than using a spinlocked and interrupt-disabled critical section.
> 
> This code has all been redone in current kernels.

Hmmm... So it has. Trond's tree hasn't caught up yet, which is a bit of a
problem:-/

David
