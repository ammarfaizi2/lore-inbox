Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264546AbUE0NuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbUE0NuF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 09:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264554AbUE0NuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 09:50:04 -0400
Received: from [213.146.154.40] ([213.146.154.40]:60071 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264550AbUE0Ntz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 09:49:55 -0400
Date: Thu, 27 May 2004 14:49:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@muc.de>
Cc: Takao Indoh <indou.takao@soft.fujitsu.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]Diskdump - yet another crash dump function
Message-ID: <20040527134951.GB15356@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@muc.de>, Takao Indoh <indou.takao@soft.fujitsu.com>,
	linux-kernel@vger.kernel.org
References: <20pwP-55v-5@gated-at.bofh.it> <m3k6yyuhvz.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3k6yyuhvz.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 03:19:44PM +0200, Andi Kleen wrote:
> Takao Indoh <indou.takao@soft.fujitsu.com> writes:
> >
> > Diskdump can be downloaded from here.
> >    http://sourceforge.net/projects/lkdump
> > Please see readme.txt which can be downloaded from this site.
> >
> > Any comments?
> 
> I like the concept - it's basically netconsole for SCSI drivers
> and the driver changes are surprisingly simple and clean.
> 
> But it would be better if it coexisted with LKCD so that netdump
> would also work. Can't you make it a low level driver for LKCD? 

LKCD is horribly bloated.  IMHO it would be better to get a lean
variant of netdump + possible this diskdump in instead of integrating
it into the monster LKCD patch.

