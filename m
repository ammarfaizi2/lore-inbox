Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264202AbUEMNya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264202AbUEMNya (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 09:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264199AbUEMNya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 09:54:30 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:52446 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264202AbUEMNy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 09:54:27 -0400
Date: Thu, 13 May 2004 14:53:08 +0100
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ak@suse.de
Subject: Re: i810 AGP fails to initialise (was Re: 2.6.6-mm2)
Message-ID: <20040513135308.GA2622@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	ak@suse.de
References: <20040513032736.40651f8e.akpm@osdl.org> <6usme4v66s.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6usme4v66s.fsf@zork.zork.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 01:54:03PM +0100, Sean Neakums wrote:
 > > bk-agpgart.patch
 > With this patch applied, agpgart doesn't initialise on my Dell
 > OptiPlex GX110, causing drm to fail to initialise.
 > 
 >   Linux agpgart interface v0.100 (c) Dave Jones
 >   [drm:i810_probe] *ERROR* Cannot initialize the agpgart module.
 > 
 > Here are the messages from successful initialisation with the patch
 > reverted.
 > 
 >   Linux agpgart interface v0.100 (c) Dave Jones
 >   agpgart: Detected an Intel i810 E Chipset.
 >   agpgart: Maximum main memory to use for agp memory: 320M
 >   agpgart: detected 4MB dedicated video ram.
 >   agpgart: AGP aperture is 64M @ 0xf8000000
 >   [drm] Initialized i810 1.4.0 20030605 on minor 0: Intel Corp. 82810E DC-133 CGC [Chipset Graphics Controller]

Damn, probably something trivially wrong in Andi's changes.

Andi?

		Dave

