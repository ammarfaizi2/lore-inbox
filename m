Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbVKULNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbVKULNa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 06:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbVKULNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 06:13:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17838 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932245AbVKULNa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 06:13:30 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <E1Ee0G0-0004CN-Az@localhost.localdomain> 
References: <E1Ee0G0-0004CN-Az@localhost.localdomain> 
To: Matthew Wilcox <matthew@wil.cx>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       David Howells <dhowells@redhat.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Mon, 21 Nov 2005 11:12:36 +0000
Message-ID: <24299.1132571556@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <matthew@wil.cx> wrote:

> +#define NO_IRQ			((unsigned int)(-1))

Should this be wrapped with #ifndef?

David
