Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbWEIPTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbWEIPTI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 11:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbWEIPTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 11:19:08 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:3747 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932520AbWEIPTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 11:19:07 -0400
Date: Tue, 9 May 2006 16:18:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Richard J Moore <richardj_moore@uk.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>, suparna@in.ibm.com
Subject: Re: [RFC] [PATCH 3/6] Kprobes: New interfaces for user-space probes
Message-ID: <20060509151857.GB16332@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Richard J Moore <richardj_moore@uk.ibm.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org,
	Prasanna S Panchamukhi <prasanna@in.ibm.com>, suparna@in.ibm.com
References: <20060509093614.GB26953@infradead.org> <OFB21F3208.CA125B3A-ON41257169.005345DD-41257169.005375F5@uk.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFB21F3208.CA125B3A-ON41257169.005345DD-41257169.005375F5@uk.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 04:11:36PM +0100, Richard J Moore wrote:
> Christoph, what are you asking for here? Surely not the RPN interpreter. I
> thought everyone agreed that that was massive bloatware and that a binary
> interface viz kprobes was a much better implementation.

I don't know what interface would be best.  I'm not pushing this big pile
of junk either.  Unless you find a suitable interface that you include in
the patchkit we're not gonna add it, even after it's been rewritten to be
sane.  So if you care to get this in find a suitable interface.

why the hell do you guys expect to get a huge piele of flaky code integrate
that slows down pagecaches and adds thousands of lines of undebuggable and
untestable code without submitting something that actually calls it.

I'd love to see the crack that's handed out at your group.
