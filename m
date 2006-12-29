Return-Path: <linux-kernel-owner+w=401wt.eu-S965113AbWL2TOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965113AbWL2TOv (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 14:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbWL2TOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 14:14:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56304 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965113AbWL2TOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 14:14:50 -0500
Date: Fri, 29 Dec 2006 14:14:47 -0500
From: Dave Jones <davej@redhat.com>
To: maximilian attems <maks@sternwelten.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 file content corruption on ext3
Message-ID: <20061229191447.GA20554@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	maximilian attems <maks@sternwelten.at>,
	linux-kernel@vger.kernel.org
References: <20061228193943.GC8940@redhat.com> <20061229092314.GB24061@nancy> <20061229150253.GB4516@redhat.com> <20061229185215.GS21469@baikonur.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061229185215.GS21469@baikonur.stro.at>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2006 at 07:52:15PM +0100, maximilian attems wrote:
 
 > > The only -mm stuff I recall being in the Fedora 2.6.18 is
 > > the inode-diet stuff which ended up in 2.6.19, though the xmas
 > > break has left my head somewhat empty so I may be forgetting something.
 > > What patch in particular are you talking about?
 > 
 > it's no longer visible in the FC6 cvs, due to rebase
 >  but it's name was linux-2.6-mm-tracking-dirty-pages.patch
 > it is an earlier almagame of the merged patch serie:
 >    - mm: tracking shared dirty pages
 >    - mm: balance dirty pages
 >    - mm: optimize the new mprotect() code a bit
 >    - mm: small cleanup of install_page()
 >    - mm: fixup do_wp_page()
 >    - mm: msync() cleanup (closes: #394392)

Ohh, that. Yes. I had forgotten all about that.
I've been hitting the nog a little too hard :)

		Dave

-- 
http://www.codemonkey.org.uk
