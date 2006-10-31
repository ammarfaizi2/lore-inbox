Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423498AbWJaPsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423498AbWJaPsm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 10:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423499AbWJaPsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 10:48:42 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:53841 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1423498AbWJaPsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 10:48:41 -0500
Date: Tue, 31 Oct 2006 07:43:45 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: "Peer Chen" <pchen@nvidia.com>, <alsa-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>, Andy Currid <ACurrid@nvidia.com>,
       Brian Lazara <BLazara@nvidia.com>, jgarzik@pobox.com,
       Emily Jiang <ejiang@nvidia.com>
Subject: Re: [Alsa-devel] [Patch] Audio: Add nvidia HD Audio controllers of
 MCP67 support to hda_intel.c
Message-Id: <20061031074345.18d57e88.randy.dunlap@oracle.com>
In-Reply-To: <s5hr6wotukx.wl%tiwai@suse.de>
References: <15F501D1A78BD343BE8F4D8DB854566B0C42D52B@hkemmail01.nvidia.com>
	<s5hr6wotukx.wl%tiwai@suse.de>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2006 15:42:54 +0100 Takashi Iwai wrote:

> At Tue, 31 Oct 2006 15:33:58 +0800,
> Peer Chen wrote:
> > 
> > Add the support for HD audio controllers of MCP51,MCP55,MCP61,MCP65 & MCP67.
> > The following hda_intel.c patch is based on kernel 2.6.18.
> > 
> > Signed-off by: Peer Chen <pchen@nvidia.com>
> 
> Applied to ALSA tree.  But I didn't add it to push-to-2.6.19-tree
> because apparently no one has tested the patch well yet.
> 
> (BTW, your patch attached there was broken, so I had to apply it
> manually.  At the next time, please either inline the patch in a text
> mail, or attach a plain text patch if inlining is not possible with
> your MUA/MTA.)

Patches should also be sent made to apply to a current kernel
tree, like 2.6.19-rc3, 2.6.19-rc4, 2.6.19-rc3-git8,
Linus's git tree, or Andrew's -mm tree if that is the only
place where the patch fits, or even to a subsystem tree (e.g., ALSA).

---
~Randy
