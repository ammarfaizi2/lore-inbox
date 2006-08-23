Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965200AbWHWU6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965200AbWHWU6H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 16:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965189AbWHWU6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 16:58:07 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:60851 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965202AbWHWU6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 16:58:04 -0400
Date: Wed, 23 Aug 2006 21:57:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephane Eranian <eranian@hpl.hp.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/18] 2.6.17.9 perfmon2 patch for review: new x86_64 files
Message-ID: <20060823205734.GA16392@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephane Eranian <eranian@hpl.hp.com>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org
References: <200608230806.k7N869KD000552@frankl.hpl.hp.com> <p73fyfn7nzz.fsf@verdi.suse.de> <20060823102932.GA697@frankl.hpl.hp.com> <20060823152555.GA32725@infradead.org> <20060823155321.GD1733@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060823155321.GD1733@frankl.hpl.hp.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 08:53:21AM -0700, Stephane Eranian wrote:
> > Please use a string name, just like every other interface for
> > such selections.
> 
> What are the advantages at the syscall level (i.e., copy_user, 
> format parsing) compared to a 16-entry byte array?

None.  In fact for a machine it doesn't matter whether you parse
an char foo[16] array as uuid or string.  The string is extremly
useful when a human enters a game, e.g. when debugging or
trouble-shooting things.  (or just reading the code)

