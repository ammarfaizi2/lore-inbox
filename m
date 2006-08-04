Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161109AbWHDIuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161109AbWHDIuW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 04:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbWHDIuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 04:50:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:694 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030209AbWHDIuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 04:50:21 -0400
Date: Fri, 4 Aug 2006 09:50:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, jes@trained-monkey.org,
       Jes Sorensen <jes@sgi.com>
Subject: Re: [patch 12/23] invalidate_bdev() speedup
Message-ID: <20060804085012.GA20026@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	stable@kernel.org, torvalds@osdl.org,
	Justin Forbes <jmforbes@linuxtx.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
	Dave Jones <davej@redhat.com>,
	Chuck Wolber <chuckw@quantumlinux.com>,
	Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
	alan@lxorguk.ukuu.org.uk, jes@trained-monkey.org,
	Jes Sorensen <jes@sgi.com>
References: <20060804053258.391158155@quad.kroah.org> <20060804053942.GM769@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060804053942.GM769@kroah.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 10:39:42PM -0700, Greg KH wrote:
> -stable review patch.  If anyone has any objections, please let us know.

This is a feature.  Definitly not -stable material.

