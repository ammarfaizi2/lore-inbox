Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbVFGTZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbVFGTZH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 15:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbVFGTZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 15:25:07 -0400
Received: from fire.osdl.org ([65.172.181.4]:57735 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261966AbVFGTYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 15:24:53 -0400
Date: Tue, 7 Jun 2005 12:24:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, ak@muc.de
Subject: Re: 2.6.12?
Message-Id: <20050607122422.612759e4.akpm@osdl.org>
In-Reply-To: <971250000.1118168167@flay>
References: <42A0D88E.7070406@pobox.com>
	<20050603163843.1cf5045d.akpm@osdl.org>
	<394120000.1117895039@[10.10.2.4]>
	<20050604151120.46b51901.akpm@osdl.org>
	<418760000.1117983740@[10.10.2.4]>
	<971250000.1118168167@flay>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@mbligh.org> wrote:
>
> > --Andrew Morton <akpm@osdl.org> wrote (on Saturday, June 04, 2005 15:11:20 -0700):
> > 
> >> "Martin J. Bligh" <mbligh@mbligh.org> wrote:
> >>> 
> >>> The one that worries me is that my x86_64 box won't boot since -rc3
> >>>  See:
> >>> 
> >>>  http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/regression_matrix.html
> 
> HA. Found it. binary search reveals it's patch 182 out of 2.6.12-rc2-mm2.
> And the winner is .... <drum roll please> ....
> 
> x86_64-use-the-e820-hole-to-map-the-iommu-agp-aperture.patch
> 

hrm.  No useful messages in dmesg?

Andi, do we revert it?
