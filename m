Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030935AbWKOT0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030935AbWKOT0z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030934AbWKOT0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:26:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:29382 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030926AbWKOT0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:26:53 -0500
Subject: Re: ANNOUNCE: SFLC helps developers assess ar5k (enabling free
	Atheros HAL)
From: Arjan van de Ven <arjan@infradead.org>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: Michael Buesch <mb@bu3sch.de>, madwifi-devel@lists.sourceforge.net,
       lwn@lwn.net, mcgrof@gmail.com, david.kimdon@devicescape.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20061115192054.GA10009@tuxdriver.com>
References: <20061115031025.GH3451@tuxdriver.com>
	 <200611151942.14596.mb@bu3sch.de>  <20061115192054.GA10009@tuxdriver.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 15 Nov 2006 20:26:29 +0100
Message-Id: <1163618789.31358.152.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-15 at 14:21 -0500, John W. Linville wrote:
> On Wed, Nov 15, 2006 at 07:42:14PM +0100, Michael Buesch wrote:
> 
> > Now that it seems to be ok to use these openbsd sources, should I port
> > them to my driver framework?
> > I looked over the ar5k code and, well, I don't like it. ;)
> > I don't really like having a HAL. I'd rather prefer a "real" driver
> > without that HAL obfuscation.
> 
> I don't think anyone likes the HAL-based architecture.  I don't think
> we will accept a HAL-based driver into the upstream kernel.
> 
> The point is that the ar5k is now safe to be used as a reference and
> source of information (and code, as appropriate) without copyright FUD.
> Distilling that information into a proper Linux driver is work that
> remains to be done.

there have been several efforts on this before; is it worth revitalizing
one of them?

Also I suspect that if you merge a provisional driver early, lots of
folks will switch to it and start beating on it and fixing the style etc
issues...


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

