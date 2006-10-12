Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422784AbWJLHb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422784AbWJLHb0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 03:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422785AbWJLHbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 03:31:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49885 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422784AbWJLHbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 03:31:24 -0400
Subject: Re: [patch 18/67] zone_reclaim: dynamic slab reclaim
From: Arjan van de Ven <arjan@infradead.org>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Christoph Lameter <clameter@sgi.com>
In-Reply-To: <20061011210453.GS16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
	 <20061011210453.GS16627@kroah.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 12 Oct 2006 09:31:14 +0200
Message-Id: <1160638274.3000.411.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-11 at 14:04 -0700, Greg KH wrote:
> plain text document attachment
> (zone_reclaim-dynamic-slab-reclaim.patch)
> -stable review patch.  If anyone has any objections, please let us know.
> 
> ------------------
> From: Christoph Lameter <clameter@sgi.com>
> 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=0ff38490c836dc379ff7ec45b10a15a662f4e5f6
> 
> 
> Currently one can enable slab reclaim by setting an explicit option in
> /proc/sys/vm/zone_reclaim_mode.  Slab reclaim is then used as a final
> option if the freeing of unmapped file backed pages is not enough to free
> enough pages to allow a local allocation.


this one adds a feature rather than a bugfix........ 

