Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267189AbUHSSd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267189AbUHSSd4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 14:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267209AbUHSSd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 14:33:56 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:32519 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267189AbUHSSdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 14:33:54 -0400
Date: Thu, 19 Aug 2004 19:33:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: jmerkey@comcast.net
Cc: linux-kernel@vger.kernel.org, jmerkey@drdos.com
Subject: Re: kallsyms 2.6.8 address ordering
Message-ID: <20040819193353.A12168@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	jmerkey@comcast.net, linux-kernel@vger.kernel.org,
	jmerkey@drdos.com
References: <081920041826.25654.4124F0D700037D32000064362200734748970A059D0A0306@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <081920041826.25654.4124F0D700037D32000064362200734748970A059D0A0306@comcast.net>; from jmerkey@comcast.net on Thu, Aug 19, 2004 at 06:26:31PM +0000
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 06:26:31PM +0000, jmerkey@comcast.net wrote:
> Yes.
> 
> What would be required?   Source code disclosure to a reviewer.  MDB is platform independent.  and patches in an alternate debugger interface in kdb_main.  In includes **NONE** of SGI's source code or Linux kernel source in the MDB core.  There is an open source section of the debugger with **ALL** modifications to kdb core files disclosed with the debugger modules.  The fact is, I don't even need kdb, but inlcuded it in a mode where folks who wanted to switch between the two debuggers could do so, since a lot of folks wanted to.  I do use the serial interface in kdb, which is the only portion.  I wrote MANOS with this debugger, and all the low level GDT, IDT, etc. hardware stuff is my own, is vastly superior to what's in kdb.   
> 
> DRDOS owns the MDB debugger for Linux now and I maintain it for them -- that's it.  I am certain DRDOS would provide any counter-claims with **FACTS** to assertions we are using any of the kdb code improperly.

So it works with unpatched kernels?

