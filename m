Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbVIIDqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbVIIDqD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 23:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbVIIDqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 23:46:03 -0400
Received: from cantor.suse.de ([195.135.220.2]:62942 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964956AbVIIDqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 23:46:02 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, JBeulich@novell.com
Subject: Re: [PATCH] minor ELF definitions addition
References: <4320670B0200007800024411@emea1-mh.id2.novell.com>
	<20050908143216.GA9665@infradead.org>
From: Andi Kleen <ak@suse.de>
Date: 09 Sep 2005 05:45:39 +0200
In-Reply-To: <20050908143216.GA9665@infradead.org>
Message-ID: <p737jdq52fw.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Thu, Sep 08, 2005 at 04:30:03PM +0200, Jan Beulich wrote:
> > (Note: Patch also attached because the inline version is certain to get
> > line wrapped.)
> > 
> > A trivial addition to the EFL definitions.
> 
> Why?  They're obviously not needed in kernelspace..

linux/elf.h has lots of stuff not needed in kernel space,
but it seems useful to make it a faithful full description
of ELF.

BTW we actually considered using TLS on x86-64 for the PDA.
The only reason it hasn't been done yet is that the necessary
binutils are not wide spread enough yet.

-Andi
