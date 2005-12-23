Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161130AbVLWXV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161130AbVLWXV5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 18:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161129AbVLWXV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 18:21:57 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:31873 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161130AbVLWXV4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 18:21:56 -0500
Date: Fri, 23 Dec 2005 15:22:19 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, torvalds@osdl.org,
       "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, linux-scsi@vger.kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>, linux-kernel@vger.kernel.org,
       Randy Dunlap <rdunlap@xenotime.net>, stefanr@s5r6.in-berlin.de,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       stable@kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [stable] Re: [patch 18/19] SCSI: fix transfer direction in scsi_lib and st
Message-ID: <20051223232219.GA1056@sorel.sous-sol.org>
References: <20051223221200.342826000@press.kroah.org> <20051223224852.GR19057@kroah.com> <1135379125.3728.57.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135379125.3728.57.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Bottomley (James.Bottomley@SteelEye.com) wrote:
> On Fri, 2005-12-23 at 14:48 -0800, Greg Kroah-Hartman wrote:
> > plain text document attachment
> > (scsi-fix-transfer-direction-in-scsi_lib-and-st.patch)
> > -stable review patch.  If anyone has any objections, please let us know.
> 
> Erm, on this diff, you're missing the function
> 
> scsi_setup_blk_pc_cmnd()
> 
> Unless these patches were split up strangely and it actually went
> through in some other patch that wasn't sent to linux-scsi?

It's in the prior patch (17/19).  It is split up a little differently.

thanks,
-chris
