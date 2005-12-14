Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbVLNLw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbVLNLw1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 06:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbVLNLw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 06:52:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:7916 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932469AbVLNLw0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 06:52:26 -0500
Date: Wed, 14 Dec 2005 12:52:00 +0100
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       dhowells@redhat.com, cfriesen@nortel.com, torvalds@osdl.org,
       hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051214115159.GG15804@wotan.suse.de>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <3874.1134480759@warthog.cambridge.redhat.com> <15167.1134488373@warthog.cambridge.redhat.com> <1134490205.11732.97.camel@localhost.localdomain> <1134556187.2894.7.camel@laptopd505.fenrus.org> <1134558188.25663.5.camel@localhost.localdomain> <1134558507.2894.22.camel@laptopd505.fenrus.org> <1134559470.25663.22.camel@localhost.localdomain> <20051214033536.05183668.akpm@osdl.org> <1134560671.2894.30.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134560671.2894.30.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * mutex use is a candidate for a "spinaphore" treatment (unlike counting
> semaphores)

I think that would be interesting experiment for page faults.
But they actually use rwsems, not normal semaphores.

-Andi
