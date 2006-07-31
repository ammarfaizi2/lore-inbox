Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWGaJnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWGaJnb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 05:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWGaJnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 05:43:31 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:47011 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750734AbWGaJna (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 05:43:30 -0400
Date: Mon, 31 Jul 2006 19:43:11 +1000
From: Nathan Scott <nathans@sgi.com>
To: kernel <linux@idccenter.cn>
Cc: jdi@l4x.org, linux-kernel@vger.kernel.org
Subject: Re: XFS Bug null pointer dereference in xfs_free_ag_extent
Message-ID: <20060731194310.A2301615@wobbly.melbourne.sgi.com>
References: <44BF29CD.1000809@l4x.org> <44CB0BF7.6030204@idccenter.cn> <44CB1303.7010303@l4x.org> <20060731094424.E2280998@wobbly.melbourne.sgi.com> <44CDA156.6000105@idccenter.cn> <20060731165522.K2280998@wobbly.melbourne.sgi.com> <44CDB135.8080401@idccenter.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <44CDB135.8080401@idccenter.cn>; from linux@idccenter.cn on Mon, Jul 31, 2006 at 03:28:53PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 03:28:53PM +0800, kernel wrote:
> I format the same partition and restart the testing server before each 
> testing.
> I'vs tested on each format at least twenty times.
> With XFS and SAN, This crash happens on every bonnie++ testing.

Its not clear to me - are you testing with the patches I mentioned
earlier reverted or not?

> And I have tested such things on another mathine, results are same.

Can you send me the xfs_info output from one of these filesystems,
and the exact bonnie++ command line used so I can reproduce it here?

thanks.

-- 
Nathan
