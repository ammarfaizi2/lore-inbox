Return-Path: <linux-kernel-owner+w=401wt.eu-S1750735AbXAEUNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbXAEUNu (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 15:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbXAEUNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 15:13:50 -0500
Received: from colo.lackof.org ([198.49.126.79]:42144 "EHLO colo.lackof.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735AbXAEUNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 15:13:49 -0500
Date: Fri, 5 Jan 2007 13:13:48 -0700
From: dann frazier <dannf@dannf.org>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Cc: linux-kernel@vger.kernel.org, md@Linux.IT, 404927@bugs.debian.org,
       404927-submitter@bugs.debian.org, debian-kernel@lists.debian.org
Subject: Re: udev/aacraid interaction - should aacraid set 'removable'?
Message-ID: <20070105201348.GC3914@colo>
References: <AE4F746F2AECFC4DA4AADD66A1DFEF0134F7DD@otce2k301.adaptec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AE4F746F2AECFC4DA4AADD66A1DFEF0134F7DD@otce2k301.adaptec.com>
User-Agent: mutt-ng/devel-r782 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2007 at 12:17:47PM -0500, Salyzyn, Mark wrote:
> The ips driver, indirectly via Firmware as it spoofs it's own inquiry
> data, reports the Removable bit set in the inquiry response for the
> arrays. The dpt_i2o driver similarly has the firmware constructing the
> bit set. Some of the Array Bridges and external RAID boxes do the same
> thing.

Thanks Mark. If you have any of these devices, could you help supply
the udevinfo information? Our udev maintainer has asked for this so
that he can workaround this issue by special casing these
devices. (See http://bugs.debian.org/404927 for details).

-- 
dann frazier

