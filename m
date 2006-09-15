Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWIOPjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWIOPjk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 11:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbWIOPjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 11:39:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32671 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932085AbWIOPjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 11:39:39 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060915173546.GE2876@slug> 
References: <20060915173546.GE2876@slug>  <20060915123132.GA4817@cathedrallabs.org> <20060915155023.GC2876@slug> <20060915151724.GA8098@cathedrallabs.org> 
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>,
       dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: cachefiles on latest -mm fails to build on powerpc 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 15 Sep 2006 16:39:33 +0100
Message-ID: <5069.1158334773@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frederik Deweerdt <deweerdt@free.fr> wrote:

> +EXPORT_SYMBOL(copy_page);

But only if !__powerpc64__.  Otherwise you need copy_4K_page to be exported
instead.

David
