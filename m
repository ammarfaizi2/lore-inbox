Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264388AbUHJKhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264388AbUHJKhm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 06:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbUHJKfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 06:35:55 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:64525 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264297AbUHJKez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 06:34:55 -0400
Date: Tue, 10 Aug 2004 11:34:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Jeff Chua <jeffchua@silk.corp.fedex.com>,
       Tomas Szepe <szepe@pinerecords.com>, netdev@oss.sgi.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ipw2100 wireless driver
Message-ID: <20040810113439.A15100@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pavel Machek <pavel@suse.cz>,
	Jeff Chua <jeffchua@silk.corp.fedex.com>,
	Tomas Szepe <szepe@pinerecords.com>, netdev@oss.sgi.com,
	kernel list <linux-kernel@vger.kernel.org>
References: <20040714114135.GA25175@elf.ucw.cz> <Pine.LNX.4.60.0407141947270.27995@boston.corp.fedex.com> <20040714115523.GC2269@elf.ucw.cz> <20040809201556.GB9677@louise.pinerecords.com> <Pine.LNX.4.61.0408101258130.1290@boston.corp.fedex.com> <20040810075558.A14154@infradead.org> <20040810101640.GF9034@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040810101640.GF9034@atrey.karlin.mff.cuni.cz>; from pavel@suse.cz on Tue, Aug 10, 2004 at 12:16:40PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 12:16:40PM +0200, Pavel Machek wrote:
> I know very little about wireless-2.6 tree (where to get it without
> bitkeeper?), but...

http://gkernel.bkbits.net:8080/wireless-2.6 it the bkweb interface, that's
the only thing I've looked at myself so far.

> task is to take ipw2100 driver, drop ieee80211_* files from it, and
> make it work with ieee80211* files from wireless-2.6?

there's no ieee80211_* files in the wireless-2.6 tree, the code is part
of hostap_*

and btw, I think hostap_* is the wrong name for the prism-specific files,
too.  I'd rather call those prism2_* or something.
