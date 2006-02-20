Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161121AbWBTUGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161121AbWBTUGQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 15:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161116AbWBTUGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 15:06:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26544 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161109AbWBTUGP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 15:06:15 -0500
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Jones <davej@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
       Greg KH <greg@kroah.com>, zanussi@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] relay: Migrate from relayfs to a generic relay API.
References: <20060219210733.GA3682@linux-sh.org>
	<20060219212122.GA7974@redhat.com>
	<20060219220840.GA14153@infradead.org>
	<20060219221330.GC7974@redhat.com>
	<20060219221724.GA14408@infradead.org>
	<20060219222943.GD7974@redhat.com>
	<20060219224820.GA14820@infradead.org>
	<20060219225437.GE7974@redhat.com>
	<20060220160313.GA31846@infradead.org>
From: fche@redhat.com (Frank Ch. Eigler)
Date: 20 Feb 2006 15:05:56 -0500
In-Reply-To: <20060220160313.GA31846@infradead.org>
Message-ID: <y0mvev9eqxn.fsf@ton.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Hellwig <hch@infradead.org> writes:

> [...]
> > the kernel bits that matter are generated at runtime.
> > I don't see anything particularly interesting in the [systemtap]
> > source tree that is worthwhile submitting.
> 
> Various helpers to write kprobes in C, instead of the funky limited
> functionality scripting language of the day. [...]

The point of the scripting language is to be safe yet expressive.  If
you or others have any specific criticisms or ideas, they are welcome
over on the systemtap@sources.redhat.com mailing list.

- FChE
