Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbULIPqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbULIPqK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 10:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbULIPqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 10:46:10 -0500
Received: from thumper2.emsphone.com ([199.67.51.102]:41357 "EHLO
	thumper2.allantgroup.com") by vger.kernel.org with ESMTP
	id S261222AbULIPqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 10:46:08 -0500
Date: Thu, 9 Dec 2004 09:45:59 -0600
From: Andy <genanr@emsphone.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Rereading disk geometry without reboot
Message-ID: <20041209154559.GA14045@thumper2>
References: <20041206202356.GA5866@thumper2> <1102437427.23136.3.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102437427.23136.3.camel@markh1.pdx.osdl.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2004 at 08:37:07AM -0800, Mark Haverkamp wrote:
> 
> You can re-scan a scsi device via sysfs.  You can, for example,
> 
> echo 1 > /sys/block/sdc/device/rescan
> 
> to rescan that device.
> 
Yes, and it reports the new size in dmesg, but when I try to grow the xfs
it doesn't grow.  It seems like some part of the kernel is not being told
about the new size of the drive. Any ideas?

Andy
