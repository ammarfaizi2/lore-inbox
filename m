Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266493AbUGPUCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266493AbUGPUCa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 16:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266567AbUGPUCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 16:02:30 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:15048 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266493AbUGPUC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 16:02:28 -0400
Date: Fri, 16 Jul 2004 21:01:13 +0100
From: Dave Jones <davej@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>, dsaxena@plexity.net, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH TRIVIAL] Add Intel IXP2400 & IXP2800 to PCI.ids
Message-ID: <20040716200113.GB20555@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>, dsaxena@plexity.net,
	greg@kroah.com, linux-kernel@vger.kernel.org
References: <20040716170832.GA4997@plexity.net> <40F81020.5010808@pobox.com> <20040716194654.GA20555@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040716194654.GA20555@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2004 at 08:46:54PM +0100, Dave Jones wrote:
 > On Fri, Jul 16, 2004 at 01:28:00PM -0400, Jeff Garzik wrote:
 > 
 >  > >This is already in sf.net, just not upstream.
 >  > 
 >  > Why not post a patch updating to latest sf.net?
 >  > 
 >  > We really need to keep the two in sync.
 > 
 > This could be trivially automated to have a script
 > grab latest, generate diff, and send a mail to Linux-kernel
 > once a week/month/whatever.
 > 
 > I'll hack something up.

Nightly snapshots will appear here..
http://www.codemonkey.org.uk/projects/pci/

I've thought again on the regular sending.. as they can be
quite large diffs occasionally, it's probably better if
gregkh pulls this into his pci tree every so often,
that way it goes into mainline semi-automatically, and
also gets some visibility in -mm for a while.

How's that sound Greg? Or would you prefer I dump
this into a bk tree you can regularly pull from?
It's only a bit more scripting to do so..

Looking at the diff is actually quite handy, theres some
bogons that have crept in there. I'll fix those up.

		Dave

