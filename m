Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbTD3Nty (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 09:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTD3Nty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 09:49:54 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:41995 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262175AbTD3Ntx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 09:49:53 -0400
Date: Wed, 30 Apr 2003 15:02:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add a stub by which a module can bind to the AFS syscall
Message-ID: <20030430150211.A7024@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <25734.1051710294@warthog.warthog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <25734.1051710294@warthog.warthog>; from dhowells@redhat.com on Wed, Apr 30, 2003 at 02:44:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 02:44:54PM +0100, David Howells wrote:
> 
> Hi Linus,
> 
> This patch makes it possible for a module to bind safely to the AFS syscall,
> without having to modify the syscall table directly.

Umm, you're adding a handler so that a module can register a variadic
multiplexer syscall??  I think you need to rething your design..
