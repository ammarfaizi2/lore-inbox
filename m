Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269020AbUJUJWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269020AbUJUJWd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 05:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268971AbUJUJVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 05:21:34 -0400
Received: from i31207.upc-i.chello.nl ([62.195.31.207]:29831 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S269022AbUJUJUn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 05:20:43 -0400
Subject: Re: [PATCH] Add key management syscalls to non-i386 archs
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: David Howells <dhowells@redhat.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <23586.1098301696@redhat.com>
References: <p73d5zdyyxc.fsf@verdi.suse.de>
	 <3506.1098283455@redhat.com.suse.lists.linux.kernel>
	 <23586.1098301696@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098350429.2810.19.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 21 Oct 2004 11:20:29 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 21:48, David Howells wrote:
> > Hey, I already allocated 248 for setaltroot. And no, you cannot
> > allocate system calls on your own without going through the 
> > architecture maintainer. The normal workflow is that you add
> > them to i386 and the other follow on their own.
> 
> That's what I intended, but others, especially Arjan, seem to think I should
> do all the compat stuff for all archs myself.

eh please don't abuse my name like that.
I asked for ONE compat emulation thing to show it can be done, that's
not the same as asking for butchering every arch.
