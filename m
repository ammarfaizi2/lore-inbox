Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbULWGjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbULWGjs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 01:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbULWGjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 01:39:47 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:12223 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S261164AbULWGjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 01:39:42 -0500
Date: Thu, 23 Dec 2004 07:39:38 +0100
From: David Weinehall <tao@debian.org>
To: Greg KH <greg@kroah.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, mochel@digitalimplant.org, axboe@suse.de
Subject: Re: /sys/block vs. /sys/class/block
Message-ID: <20041223063938.GA27718@khan.acc.umu.se>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel@vger.kernel.org, mochel@digitalimplant.org,
	axboe@suse.de
References: <1103526532.5320.33.camel@gaston> <20041220224950.GA21317@kroah.com> <1103612870.21771.22.camel@gaston> <20041222153449.46da0671.sfr@canb.auug.org.au> <20041222062057.GC31513@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041222062057.GC31513@kroah.com>
User-Agent: Mutt/1.4.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 10:20:57PM -0800, Greg KH wrote:

[snip]

> It is gross.

Indeed.

> But I guess I should ask, who really cares about this, so late in the
> sysfs structure game?  Is /sys/block/ really a big problem for anyone?
> And if it is, I'd much rather someone make the required driver core
> changes to fix this up properly, than just put a symlink to paper over
> some userspace issue.

Maybe because *for once* it'd be nice to actually have inconsistencies
gotten rid of in their relative infancy instead of waiting 10 years
and then having to explain them as existing only for hysterical
raisins...

[snip]


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
