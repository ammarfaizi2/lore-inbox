Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263111AbSJBM4C>; Wed, 2 Oct 2002 08:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263112AbSJBM4C>; Wed, 2 Oct 2002 08:56:02 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:55556 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263111AbSJBM4B>; Wed, 2 Oct 2002 08:56:01 -0400
Date: Wed, 2 Oct 2002 14:01:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Robert Love <rml@tech9.net>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
Message-ID: <20021002140124.B2141@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Robert Love <rml@tech9.net>, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org
References: <1033513407.12959.91.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1033513407.12959.91.camel@phantasy>; from rml@tech9.net on Tue, Oct 01, 2002 at 07:03:28PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 07:03:28PM -0400, Robert Love wrote:
> The following patch implements set_cpus_allowed() for stock 2.4 without
> the O(1) scheduler.
> 
> The calling semantics and behavior remain the same as 2.5's method.
> 
> This is to provide a backward-compatible interface, specifically for
> those interested in back-porting the new workqueue code to 2.4 -
> set_cpus_allowed() seems to be the only nit preventing a straight
> drop-in.
> 
> Patch is against 2.4.20-pre8 and untested but does compile.

Patch looks good to me, and I'd really like to have it in XFS :)
BTW, now that you have the core functionality I wonder why you don't
also add the cpu affinity syscalls..

