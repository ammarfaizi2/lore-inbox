Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbTD3OeR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 10:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbTD3OeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 10:34:17 -0400
Received: from havoc.daloft.com ([64.213.145.173]:26326 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261809AbTD3OeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 10:34:17 -0400
Date: Wed, 30 Apr 2003 10:46:38 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add a stub by which a module can bind to the AFS syscall
Message-ID: <20030430144638.GB25076@gtf.org>
References: <25734.1051710294@warthog.warthog> <20030430150211.A7024@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030430150211.A7024@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 03:02:11PM +0100, Christoph Hellwig wrote:
> On Wed, Apr 30, 2003 at 02:44:54PM +0100, David Howells wrote:
> > 
> > Hi Linus,
> > 
> > This patch makes it possible for a module to bind safely to the AFS syscall,
> > without having to modify the syscall table directly.
> 
> Umm, you're adding a handler so that a module can register a variadic
> multiplexer syscall??  I think you need to rething your design..

It's better than the alternative, having OpenAFS patch the system
call table itself... ;-)

	Jeff



