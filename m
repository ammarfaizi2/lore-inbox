Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWGLTyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWGLTyM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 15:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWGLTyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 15:54:12 -0400
Received: from sunsite.ms.mff.cuni.cz ([195.113.15.26]:38844 "EHLO
	sunsite.mff.cuni.cz") by vger.kernel.org with ESMTP id S932085AbWGLTyL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 15:54:11 -0400
Date: Wed, 12 Jul 2006 21:53:49 +0200
From: Jakub Jelinek <jakub@redhat.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Roland McGrath <roland@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Arjan van de Ven <arjan@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
Message-ID: <20060712195349.GW3823@sunsite.mff.cuni.cz>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20060712184412.2BD57180061@magilla.sf.frob.com> <44B54EA4.5060506@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B54EA4.5060506@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 12:33:56PM -0700, Ulrich Drepper wrote:
> Roland McGrath wrote:
> > We could also put the uname info (modulo nodename) into the vDSO.
> 
> Or even better: real topology information.

AND rather than OR would be even better.  So glibc could find kernel
version, etc. and topology in the vDSO cheaply.

	Jakub
