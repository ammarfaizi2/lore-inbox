Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266560AbTAKK6g>; Sat, 11 Jan 2003 05:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267187AbTAKK6g>; Sat, 11 Jan 2003 05:58:36 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:64786 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266560AbTAKK6e>; Sat, 11 Jan 2003 05:58:34 -0500
Date: Sat, 11 Jan 2003 11:07:17 +0000
From: Christoph Hellwig <hch@infradead.org>
To: davidm@hpl.hp.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: make AT_SYSINFO platform-independent
Message-ID: <20030111110717.A24094@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, davidm@hpl.hp.com,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <200301110645.h0B6jQRu026921@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301110645.h0B6jQRu026921@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Fri, Jan 10, 2003 at 10:45:26PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 10:45:26PM -0800, David Mosberger wrote:
> How about moving the AT_SYSINFO macro from asm-i386/elf.h to
> linux/elf.h?  Several architectures can benefit from it (certainly
> pa-risc and ia64) and since glibc also defines it in a
> non-platformspecific fashion, there really is no point not doing the
> same in the kernel.  I suppose it would be nice if we could renumber
> it from 32 to 18, but that would require updating glibc, which is
> probably too painful.

I think it should be updated.  There is no released glibc or stable kernel
with that number yet.

