Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWCCOTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWCCOTv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 09:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWCCOTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 09:19:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6835 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751156AbWCCOTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 09:19:51 -0500
Date: Fri, 3 Mar 2006 14:19:47 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: roland <devzero@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: is there a COW inside the kernel ?
Message-ID: <20060303141947.GC25334@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	roland <devzero@web.de>, linux-kernel@vger.kernel.org
References: <043101c63e9c$86e9d710$0200000a@aldipc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <043101c63e9c$86e9d710$0200000a@aldipc>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 09:29:02AM +0100, roland wrote:
> is there an equivalent of something like
> cowloop ( http://www.atconsultancy.nl/cowloop/total.html ) or md based cow 
> device ( http://www.cl.cam.ac.uk/users/br260/doc/report.pdf ),
> i.e. a feature called "Copy On Write Blockdevice" inside the current or the 
> near-future mainline kernel (besides UserModeLinux Arch)?
 
device-mapper snapshots?

  Documentation/device-mapper/snapshot.txt

Alasdair
-- 
agk@redhat.com
