Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbWFPPpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWFPPpY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 11:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWFPPpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 11:45:23 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:30176 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751463AbWFPPpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 11:45:22 -0400
Date: Fri, 16 Jun 2006 16:45:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: eranian@hpl.hp.com, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, systemtap@sources.redhat.com,
       wcohen@redhat.com, perfmon@napali.hpl.hp.com
Subject: Re: [PATCH 9/16] 2.6.17-rc6 perfmon2 patch for review: kernel-level API support (kapi)
Message-ID: <20060616154519.GA28931@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Frank Ch. Eigler" <fche@redhat.com>, eranian@hpl.hp.com,
	linux-kernel@vger.kernel.org, systemtap@sources.redhat.com,
	wcohen@redhat.com, perfmon@napali.hpl.hp.com
References: <200606150907.k5F97coF008178@frankl.hpl.hp.com> <20060616135014.GB12657@infradead.org> <20060616140234.GI10034@frankl.hpl.hp.com> <y0mhd2lumz7.fsf@ton.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y0mhd2lumz7.fsf@ton.toronto.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2006 at 11:41:32AM -0400, Frank Ch. Eigler wrote:
> Whether one uses systemtap, raw kprobes, or some specialized
> tracing/stats-collecting patch surely forthcoming, kernel-level APIs
> would be needed to perform fine-grained kernel-scope measurements
> using these counters.

No, there's not need to add kernel bloat for performance monitoring.
This kind of stuff shoul dabsolutely be done from userspace.

