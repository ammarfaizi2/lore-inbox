Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268024AbUH1V0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268024AbUH1V0g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 17:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268019AbUH1VYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 17:24:49 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:28427 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267974AbUH1VWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 17:22:13 -0400
Date: Sat, 28 Aug 2004 22:22:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Jones <davej@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm Kconfig fixes
Message-ID: <20040828222206.A11969@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200408280309.i7S39PPv000756@hera.kernel.org> <20040828210533.GD6301@redhat.com> <20040828221345.A11901@infradead.org> <20040828211717.GF6301@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040828211717.GF6301@redhat.com>; from davej@redhat.com on Sat, Aug 28, 2004 at 10:17:17PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 10:17:17PM +0100, Dave Jones wrote:
> On Sat, Aug 28, 2004 at 10:13:45PM +0100, Christoph Hellwig wrote:
>  > On Sat, Aug 28, 2004 at 10:05:33PM +0100, Dave Jones wrote:
>  > > Even if not,  I think I'd actually prefer a whitelist of drivers that *do*
>  > > support agpgart in the Kconfig, than the above which needs to be added to
>  > > all the time.  Something like if X86 && ALPHA && IA64 should cover it currently.
>  > 
>  > PPC
> 
> Bah, I *knew* I'd miss one. I even read the Kconfig twice after missing IA64.
> I suck. I still stand by my claim that it would look better though.

Completely agreed on that one.  Negative depencies are a bad idea in general.
