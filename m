Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbUKCUlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUKCUlD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 15:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbUKCUlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 15:41:02 -0500
Received: from albireo.enyo.de ([212.9.189.169]:39850 "EHLO albireo.enyo.de")
	by vger.kernel.org with ESMTP id S261867AbUKCUkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 15:40:21 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       davidm@snapgear.com, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org
Subject: Re: [PATCH 12/14] FRV: Generate more useful debug info
References: <20041101162929.63af1d0d.akpm@osdl.org>
	<76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com>
	<200411011930.iA1JUMgs023243@warthog.cambridge.redhat.com>
	<5109.1099394496@redhat.com>
	<Pine.LNX.4.58.0411021747420.2187@ppc970.osdl.org>
	<Pine.LNX.4.58.0411021750440.2187@ppc970.osdl.org>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Wed, 03 Nov 2004 21:40:04 +0100
In-Reply-To: <Pine.LNX.4.58.0411021750440.2187@ppc970.osdl.org> (Linus
	Torvalds's message of "Tue, 2 Nov 2004 17:52:45 -0800 (PST)")
Message-ID: <87wtx2oee3.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds:

>> That may not be true today, but what is true is that -O1 is not a light 
>> thing to just do.
>
> And btw, in some cases the inlining used to be a correcness issue, so no,
> just making it be "static inline" doesn't necessarily fix the basic issue. 

But the always_inline attribute hopefully does.
