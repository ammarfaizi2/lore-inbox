Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTETBhy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 21:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263455AbTETBhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 21:37:54 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:54914 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263452AbTETBhx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 21:37:53 -0400
Date: Tue, 20 May 2003 02:50:47 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [patch] futex API cleanups, futex-api-cleanup-2.5.69-A2
Message-ID: <20030520015047.GB14851@mail.jlokier.co.uk>
References: <20030519233353.GD13706@mail.jlokier.co.uk> <20030520010913.3300F2C05E@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030520010913.3300F2C05E@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 2) Control the number which can be used at once.
> The current implementation needs a tighter #2.

Alternatively, make a page swappable even while it's being waited on
somehow.  Can the vcache help with that?

-- Jamie

