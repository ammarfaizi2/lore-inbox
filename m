Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWEIWfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWEIWfi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 18:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWEIWfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 18:35:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:45204 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751306AbWEIWfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 18:35:37 -0400
Date: Tue, 9 May 2006 23:35:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: Adrian Bunk <bunk@stusta.de>, Christoph Hellwig <hch@infradead.org>,
       Richard J Moore <richardj_moore@uk.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>, suparna@in.ibm.com
Subject: Re: [RFC] [PATCH 3/6] Kprobes: New interfaces for user-space probes
Message-ID: <20060509223529.GB14753@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Frank Ch. Eigler" <fche@redhat.com>, Adrian Bunk <bunk@stusta.de>,
	Richard J Moore <richardj_moore@uk.ibm.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org,
	Prasanna S Panchamukhi <prasanna@in.ibm.com>, suparna@in.ibm.com
References: <20060509093614.GB26953@infradead.org> <OFB21F3208.CA125B3A-ON41257169.005345DD-41257169.005375F5@uk.ibm.com> <20060509151857.GB16332@infradead.org> <y0mk68vyu2y.fsf@ton.toronto.redhat.com> <20060509204052.GN3570@stusta.de> <20060509205835.GD13413@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509205835.GD13413@redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 04:58:35PM -0400, Frank Ch. Eigler wrote:
> Hi -
> 
> On Tue, May 09, 2006 at 10:40:52PM +0200, Adrian Bunk wrote:
> > > It is reasonable to want to see code that exercises this function.
> > > Until systemtap does, hand-written examples can surely be provided.
> > 
> > It's not about examples, it's about in-kernel users.
> 
> Just as for kprobes, this facility is for dynamically generated
> kernel-resident code.

kprobes is not for "dynamically generated kernel-resident code".  That's
just what you abuse it for. 

