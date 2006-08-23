Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbWHWP0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbWHWP0a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 11:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbWHWP0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 11:26:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:63974 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964979AbWHWP0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 11:26:30 -0400
Date: Wed, 23 Aug 2006 16:25:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephane Eranian <eranian@hpl.hp.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/18] 2.6.17.9 perfmon2 patch for review: new x86_64 files
Message-ID: <20060823152555.GA32725@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephane Eranian <eranian@hpl.hp.com>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org
References: <200608230806.k7N869KD000552@frankl.hpl.hp.com> <p73fyfn7nzz.fsf@verdi.suse.de> <20060823102932.GA697@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060823102932.GA697@frankl.hpl.hp.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 03:29:32AM -0700, Stephane Eranian wrote:
> > > +#define PFM_EM64T_PEBS_SMPL_UUID { \
> > > +	0x36, 0xbe, 0x97, 0x94, 0x1f, 0xbf, 0x41, 0xdf,\
> > > +	0xb4, 0x63, 0x10, 0x62, 0xeb, 0x72, 0x9b, 0xad}
> > 
> > What does it need the UUID for?
> > 
> Every sampling format is identified by a UUID. This  is how an
> application can identify the format it wants to use when it
> creates a context.

Please use a string name, just like every other interface for
such selections.

