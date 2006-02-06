Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWBFVdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWBFVdF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 16:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWBFVdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 16:33:04 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:61074 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932169AbWBFVdD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 16:33:03 -0500
Date: Tue, 7 Feb 2006 08:32:57 +1100
From: Nathan Scott <nathans@sgi.com>
To: Luca <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [BUG] Linux 2.6.16-rcX breaks mutt
Message-ID: <20060207083256.D9093411@wobbly.melbourne.sgi.com>
References: <20060206172141.GA15133@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060206172141.GA15133@dreamland.darkstar.lan>; from kronos@kronoz.cjb.net on Mon, Feb 06, 2006 at 06:21:41PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2006 at 06:21:41PM +0100, Luca wrote:
> Hi,

Hi Luca,

> I found out that mutt when running with a 2.6.16-rcX kernel is unable to
> discover new mails in mboxes other than the main one.
> ...
> I think that the problem is related to the changes in:
> fs/xfs/linux-2.6/xfs_iops.c

Indeed, there have been some atime related changes recently.

> I've done a simple test with working and non working system:

Thanks for the details, I should be able to reproduce and fix it
from that - I'll get back to you soon.

cheers.

--
Nathan
