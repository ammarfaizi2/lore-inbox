Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754533AbWKHLbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754533AbWKHLbH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 06:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754537AbWKHLbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 06:31:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13280 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1754533AbWKHLbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 06:31:05 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061106150329.GA226@oleg> 
References: <20061106150329.GA226@oleg> 
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: David Howells <dhowells@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] a minor fix for set_mb() in Documentation/memory-barriers.txt 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 08 Nov 2006 11:29:10 +0000
Message-ID: <11039.1162985350@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> wrote:

> set_mb() is used by set_current_state() which needs mb(), not wmb().
> I think it would be right to assume that set_mb() implies mb(), all
> arches seem to do just this.

Yes, you're right.  Copy'n'paste error from the text about set_wmb() I think.

Acked-By: David Howells <dhowells@redhat.com>
