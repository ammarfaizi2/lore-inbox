Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbULHGeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbULHGeb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 01:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbULHGeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 01:34:31 -0500
Received: from fmr16.intel.com ([192.55.52.70]:20132 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S261741AbULHGe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 01:34:28 -0500
Subject: Re: 2.4.27 -> 2.4.28 breaks i810-tco watchdog timer
From: Len Brown <len.brown@intel.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Simon Byrnand <simon@igrin.co.nz>, linux-kernel@vger.kernel.org,
       Shaohua Li <shaohua.li@intel.com>
In-Reply-To: <20041208054834.GD17946@alpha.home.local>
References: <20041208054834.GD17946@alpha.home.local>
Content-Type: text/plain
Organization: 
Message-Id: <1102487662.2196.18.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 08 Dec 2004 01:34:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 00:48, Willy Tarreau wrote:
> Hi,
> 
> On Wed, Dec 08, 2004 at 08:59:35AM +1300, Simon Byrnand wrote:
> (...)
> > e400-e47f : motherboard
> > e800-e81f : motherboard
> > ec00-ec3f : motherboard
> > f000-f00f : Intel Corp. 82801DB Ultra ATA Storage Controller
> >   f000-f007 : ide0
> >   f008-f00f : ide1
> > 
> > Clearly the IO range the driver is trying to open is already in use
> by
> > "motherboard". If I check another almost identical machine still
> running


Does this patch in 2.4.29 help?
http://linux.bkbits.net:8080/linux-2.4/cset@41a29b2db1heWGdXTVfdZPyWafsD8g


