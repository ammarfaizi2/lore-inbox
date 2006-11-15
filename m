Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030924AbWKOTV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030924AbWKOTV7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030926AbWKOTV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:21:59 -0500
Received: from ra.tuxdriver.com ([70.61.120.52]:14347 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1030924AbWKOTV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:21:57 -0500
Date: Wed, 15 Nov 2006 14:21:05 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Michael Buesch <mb@bu3sch.de>
Cc: madwifi-devel@lists.sourceforge.net, lwn@lwn.net, mcgrof@gmail.com,
       david.kimdon@devicescape.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: ANNOUNCE: SFLC helps developers assess ar5k (enabling free Atheros HAL)
Message-ID: <20061115192054.GA10009@tuxdriver.com>
References: <20061115031025.GH3451@tuxdriver.com> <200611151942.14596.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611151942.14596.mb@bu3sch.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2006 at 07:42:14PM +0100, Michael Buesch wrote:

> Now that it seems to be ok to use these openbsd sources, should I port
> them to my driver framework?
> I looked over the ar5k code and, well, I don't like it. ;)
> I don't really like having a HAL. I'd rather prefer a "real" driver
> without that HAL obfuscation.

I don't think anyone likes the HAL-based architecture.  I don't think
we will accept a HAL-based driver into the upstream kernel.

The point is that the ar5k is now safe to be used as a reference and
source of information (and code, as appropriate) without copyright FUD.
Distilling that information into a proper Linux driver is work that
remains to be done.

John
-- 
John W. Linville
linville@tuxdriver.com
